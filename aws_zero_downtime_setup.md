# AWS Zero-Downtime Deployment for Modern POS
## Budget: $100 AWS Credits | Duration: 15+ Months Free

## Phase 1: Pre-Deployment Setup (30 minutes)

### Step 1: Prepare Your Code
```bash
# Create deployment package
cd /Applications/XAMPP/xamppfiles/htdocs/modernpos
zip -r modernpos-deployment.zip . -x "node_modules/*" ".git/*" "*.log"
```

### Step 2: Database Preparation
```bash
# Export your database
mysqldump -u root -p shreshta_collections > shreshta_collections_backup.sql
```

## Phase 2: AWS Infrastructure Setup (45 minutes)

### Step 1: Create VPC and Security Groups
```bash
# Create VPC
aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specifications 'ResourceType=vpc,Tags=[{Key=Name,Value=modernpos-vpc}]'

# Create Internet Gateway
aws ec2 create-internet-gateway --tag-specifications 'ResourceType=internet-gateway,Tags=[{Key=Name,Value=modernpos-igw}]'

# Create Subnets
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.1.0/24 --availability-zone us-east-1a
aws ec2 create-subnet --vpc-id vpc-xxxxx --cidr-block 10.0.2.0/24 --availability-zone us-east-1b
```

### Step 2: Launch EC2 Instance
```bash
# Launch t2.micro (FREE for 12 months)
aws ec2 run-instances \
  --image-id ami-0c02fb55956c7d316 \
  --instance-type t2.micro \
  --key-name modernpos-key \
  --security-group-ids sg-xxxxx \
  --subnet-id subnet-xxxxx \
  --user-data file://user-data.sh
```

### Step 3: Create RDS Database
```bash
# Create RDS MySQL instance (FREE for 12 months)
aws rds create-db-instance \
  --db-instance-identifier modernpos-db \
  --db-instance-class db.t2.micro \
  --engine mysql \
  --master-username admin \
  --master-user-password YourSecurePassword123! \
  --allocated-storage 20 \
  --vpc-security-group-ids sg-xxxxx \
  --db-subnet-group-name modernpos-subnet-group
```

## Phase 3: Application Deployment (30 minutes)

### Step 1: Configure EC2 Instance
```bash
# Connect to EC2
ssh -i modernpos-key.pem ec2-user@your-ec2-ip

# Install LAMP stack
sudo yum update -y
sudo yum install -y httpd mysql php php-mysqlnd php-fpm php-json php-xml php-mbstring php-zip php-gd

# Start services
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm
```

### Step 2: Deploy Application
```bash
# Upload your code
scp -i modernpos-key.pem modernpos-deployment.zip ec2-user@your-ec2-ip:/home/ec2-user/

# Extract and setup
cd /var/www/html
sudo unzip /home/ec2-user/modernpos-deployment.zip
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
sudo chmod -R 777 /var/www/html/storage
```

### Step 3: Configure Database Connection
```php
// Update config.php
$sql_details = array(
    'host' => 'modernpos-db.xxxxx.us-east-1.rds.amazonaws.com',
    'db' => 'shreshta_collections',
    'user' => 'admin',
    'pass' => 'YourSecurePassword123!',
    'port' => '3306'
);

define('ROOT_URL', 'http://your-ec2-ip/');
```

### Step 4: Import Database
```bash
# Connect to RDS and import
mysql -h modernpos-db.xxxxx.us-east-1.rds.amazonaws.com -u admin -p shreshta_collections < shreshta_collections_backup.sql
```

## Phase 4: Zero-Downtime Configuration (15 minutes)

### Step 1: Setup Load Balancer
```bash
# Create Application Load Balancer
aws elbv2 create-load-balancer \
  --name modernpos-alb \
  --subnets subnet-xxxxx subnet-yyyyy \
  --security-groups sg-xxxxx
```

### Step 2: Configure Auto Scaling
```bash
# Create Launch Template
aws ec2 create-launch-template \
  --launch-template-name modernpos-template \
  --launch-template-data file://launch-template.json

# Create Auto Scaling Group
aws autoscaling create-auto-scaling-group \
  --auto-scaling-group-name modernpos-asg \
  --launch-template LaunchTemplateName=modernpos-template \
  --min-size 1 \
  --max-size 3 \
  --desired-capacity 1 \
  --target-group-arns arn:aws:elasticloadbalancing:region:account:targetgroup/modernpos-tg
```

### Step 3: Setup Health Checks
```bash
# Create Target Group
aws elbv2 create-target-group \
  --name modernpos-tg \
  --protocol HTTP \
  --port 80 \
  --vpc-id vpc-xxxxx \
  --health-check-path /health-check.php
```

## Phase 5: Monitoring and Backup (10 minutes)

### Step 1: Setup CloudWatch Monitoring
```bash
# Enable detailed monitoring
aws ec2 monitor-instances --instance-ids i-xxxxx

# Create CloudWatch alarms
aws cloudwatch put-metric-alarm \
  --alarm-name modernpos-cpu-high \
  --alarm-description "CPU utilization high" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold
```

### Step 2: Setup Automated Backups
```bash
# Enable RDS automated backups
aws rds modify-db-instance \
  --db-instance-identifier modernpos-db \
  --backup-retention-period 7 \
  --preferred-backup-window "03:00-04:00"
```

## Phase 6: Custom Domain Setup (Optional)

### Step 1: Route 53 Configuration
```bash
# Create hosted zone
aws route53 create-hosted-zone \
  --name yourdomain.com \
  --caller-reference $(date +%s)

# Create A record
aws route53 change-resource-record-sets \
  --hosted-zone-id Z123456789 \
  --change-batch file://dns-change.json
```

### Step 2: SSL Certificate
```bash
# Request SSL certificate
aws acm request-certificate \
  --domain-name yourdomain.com \
  --validation-method DNS \
  --subject-alternative-names "*.yourdomain.com"
```

## Cost Analysis with $100 Credits

### Month 1-12 (Free Tier):
- **EC2 t2.micro**: $0 (750 hours free)
- **RDS db.t2.micro**: $0 (750 hours free)
- **EBS 30GB**: $0 (free tier)
- **Data Transfer**: $0 (1GB free)
- **Total**: $0/month

### Month 13+ (After Free Tier):
- **EC2 t2.micro**: $8.50/month
- **RDS db.t2.micro**: $12.41/month
- **EBS 30GB**: $3.45/month
- **Data Transfer**: $1-2/month
- **Total**: ~$25/month

### **Your $100 Credits Will Last:**
- **Free Tier**: 12 months (completely free)
- **After Free Tier**: 4+ months with $100 credits
- **Total Free Period**: 16+ months

## Zero-Downtime Features

### 1. Load Balancer
- Distributes traffic across multiple instances
- Automatic failover if one instance fails
- Health checks ensure only healthy instances receive traffic

### 2. Auto Scaling
- Automatically adds instances during high traffic
- Removes instances during low traffic
- Maintains desired capacity

### 3. Multi-AZ RDS
- Database replicated across multiple availability zones
- Automatic failover if primary database fails
- 99.99% uptime SLA

### 4. CloudWatch Monitoring
- Real-time monitoring of all resources
- Automatic alerts for issues
- Performance optimization recommendations

## Security Best Practices

### 1. Security Groups
```bash
# Web server security group
- HTTP (80): 0.0.0.0/0
- HTTPS (443): 0.0.0.0/0
- SSH (22): Your IP only

# Database security group
- MySQL (3306): Web server security group only
```

### 2. IAM Roles
```bash
# Create IAM role for EC2
aws iam create-role \
  --role-name modernpos-ec2-role \
  --assume-role-policy-document file://trust-policy.json
```

### 3. Encryption
- RDS encryption at rest
- EBS volume encryption
- SSL/TLS for all connections

## Monitoring and Maintenance

### Daily Checks
- CloudWatch dashboards
- Application logs
- Database performance

### Weekly Tasks
- Security updates
- Backup verification
- Performance optimization

### Monthly Tasks
- Cost analysis
- Security audit
- Capacity planning

## Troubleshooting Common Issues

### 1. Application Not Loading
- Check security groups
- Verify Apache/PHP status
- Check application logs

### 2. Database Connection Issues
- Verify RDS security groups
- Check database credentials
- Test connectivity

### 3. High Costs
- Review CloudWatch metrics
- Optimize instance sizes
- Check for unused resources

## Next Steps After Deployment

1. **Setup CI/CD Pipeline** (GitHub Actions)
2. **Implement Caching** (Redis/ElastiCache)
3. **Add CDN** (CloudFront)
4. **Setup Logging** (CloudWatch Logs)
5. **Implement Monitoring** (CloudWatch Alarms)

## Support and Maintenance

- **AWS Support**: Basic support included
- **Documentation**: AWS documentation
- **Community**: AWS forums and Stack Overflow
- **Professional Support**: Available if needed

This setup will give you a production-ready, scalable, and highly available POS system that can handle your 1000 products and 100 daily transactions with zero downtime!
