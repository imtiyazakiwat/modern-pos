# AWS Complete Deployment Guide for Modern POS System
## Zero-Downtime Architecture | $100 Credits | 16+ Months Free

## Table of Contents
1. [Overview](#overview)
2. [Prerequisites](#prerequisites)
3. [AWS Account Setup](#aws-account-setup)
4. [Infrastructure Architecture](#infrastructure-architecture)
5. [EC2 Instance Setup](#ec2-instance-setup)
6. [RDS Database Setup](#rds-database-setup)
7. [Application Deployment](#application-deployment)
8. [Load Balancer Configuration](#load-balancer-configuration)
9. [Auto Scaling Setup](#auto-scaling-setup)
10. [Domain and SSL Setup](#domain-and-ssl-setup)
11. [Monitoring and Alerts](#monitoring-and-alerts)
12. [Backup Strategy](#backup-strategy)
13. [Cost Analysis](#cost-analysis)
14. [Troubleshooting](#troubleshooting)
15. [Maintenance](#maintenance)

---

## Overview

This guide will help you deploy your Modern POS system on AWS with:
- ✅ **Zero-downtime architecture**
- ✅ **Auto-scaling capabilities**
- ✅ **Load balancing**
- ✅ **Automated backups**
- ✅ **Free subdomain** (`your-app.region.elb.amazonaws.com`)
- ✅ **SSL certificate**
- ✅ **Monitoring and alerts**
- ✅ **$100 credits = 16+ months free**

### Cost Breakdown:
- **Months 1-12**: $0 (Free Tier)
- **Months 13+**: ~$25/month
- **Total Free Period**: 16+ months

---

## Prerequisites

### System Requirements
- ✅ **Products**: 1,000 products
- ✅ **Daily Transactions**: ~100 bills/day
- ✅ **Database Size**: 50-100MB
- ✅ **Traffic**: Low to medium

### Software Requirements
- ✅ **AWS Account** with $100 credits
- ✅ **Modern POS code** (current version)
- ✅ **Database backup** (`shreshta_collections.sql`)
- ✅ **SSH client** (Terminal/PuTTY)
- ✅ **File transfer tool** (WinSCP/FileZilla)

### AWS Services Used
- **EC2**: Virtual servers
- **RDS**: Managed MySQL database
- **ELB**: Load balancer
- **Auto Scaling**: Automatic scaling
- **Route 53**: DNS management
- **CloudWatch**: Monitoring
- **ACM**: SSL certificates

---

## AWS Account Setup

### Step 1: Create AWS Account
1. Go to [https://aws.amazon.com](https://aws.amazon.com)
2. Click **"Create an AWS Account"**
3. Enter your email and create password
4. Add credit card information (won't be charged for free tier)
5. Verify your phone number
6. Choose **"Basic Support"** (free)

### Step 2: Activate Free Credits (if available)
1. Go to **AWS Billing Dashboard**
2. Look for **"Credits"** section
3. Apply any promotional credits ($100)

### Step 3: Create IAM User (Security Best Practice)
```bash
# Create IAM user with limited permissions
aws iam create-user --user-name modernpos-admin
aws iam attach-user-policy --user-name modernpos-admin \
  --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
aws iam create-access-key --user-name modernpos-admin
```

---

## Infrastructure Architecture

### Zero-Downtime Architecture Diagram

```
Internet Users
      ↓
[CloudFront CDN] (Optional - for static assets)
      ↓
[Application Load Balancer]
      ↓
[Auto Scaling Group]
┌─────────────────┐
│ EC2 Instance 1  │ ← Health Checks
│ Web Server      │
│ PHP + Apache    │
└─────────────────┘
      ↓
┌─────────────────┐
│ RDS MySQL       │ ← Multi-AZ
│ Database        │   Replication
│ (Read Replica)  │
└─────────────────┘
      ↓
[Automated Backups]
[S3 Storage]
[CloudWatch Monitoring]
```

### Components:
- **Load Balancer**: Distributes traffic, SSL termination
- **Auto Scaling**: Adds/removes servers automatically
- **EC2 Instances**: Your application servers
- **RDS Multi-AZ**: Database with automatic failover
- **CloudWatch**: Monitoring and alerts
- **S3**: File storage and backups

---

## EC2 Instance Setup

### Step 1: Launch EC2 Instance
1. Go to **AWS Console** → **EC2**
2. Click **"Launch Instance"**
3. Choose **"Amazon Linux 2 AMI"**
4. Select **"t2.micro"** (Free Tier)
5. Configure instance:
   - **Network**: Default VPC
   - **Auto-assign Public IP**: Enable
   - **Security Group**: Create new
     - Name: `modernpos-web-sg`
     - Rules:
       - SSH (22) → Your IP only
       - HTTP (80) → 0.0.0.0/0
       - HTTPS (443) → 0.0.0.0/0

### Step 2: Install LAMP Stack
```bash
# Connect to your EC2 instance
ssh -i your-key.pem ec2-user@your-ec2-public-ip

# Update system
sudo yum update -y

# Install Apache, PHP, MySQL client
sudo yum install -y httpd php php-mysqlnd php-fpm php-json php-xml php-mbstring php-zip php-gd php-curl php-intl

# Start and enable services
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start php-fpm
sudo systemctl enable php-fpm

# Install additional PHP extensions your POS might need
sudo yum install -y php-pdo php-mysqli php-sqlite3 php-bcmath
```

### Step 3: Configure Apache
```bash
# Create Apache configuration
sudo tee /etc/httpd/conf.d/modernpos.conf > /dev/null <<EOF
<VirtualHost *:80>
    ServerName your-domain.com
    DocumentRoot /var/www/html

    <Directory /var/www/html>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/httpd/modernpos_error.log
    CustomLog /var/log/httpd/modernpos_access.log combined
</VirtualHost>
EOF

# Restart Apache
sudo systemctl restart httpd
```

### Step 4: Upload Your Application Code
```bash
# Create application directory
sudo mkdir -p /var/www/html
sudo chown -R ec2-user:ec2-user /var/www/html

# Upload your code (replace with your upload method)
# Option 1: Using SCP
scp -i your-key.pem -r /path/to/modernpos/* ec2-user@your-ec2-ip:/var/www/html/

# Option 2: Using Git
cd /var/www/html
git clone https://github.com/yourusername/modernpos.git .
```

### Step 5: Set Proper Permissions
```bash
# Set ownership and permissions
sudo chown -R apache:apache /var/www/html
sudo chmod -R 755 /var/www/html
sudo chmod -R 777 /var/www/html/storage
sudo chmod -R 777 /var/www/html/_inc/config
```

---

## RDS Database Setup

### Step 1: Create RDS Instance
1. Go to **AWS Console** → **RDS**
2. Click **"Create database"**
3. Choose **"MySQL"** engine
4. Select **"Free tier"** template
5. Database settings:
   - **DB instance identifier**: `modernpos-db`
   - **Master username**: `admin`
   - **Master password**: `YourSecurePassword123!`
   - **Database name**: `shreshta_collections`
6. Instance configuration:
   - **DB instance class**: `db.t2.micro`
   - **Storage**: 20 GB (SSD)
7. Connectivity:
   - **VPC**: Same as EC2
   - **Subnet group**: Default
   - **Public access**: No (we'll use private IP)
   - **VPC security group**: Create new (`modernpos-db-sg`)

### Step 2: Configure Security Group
1. Go to **EC2** → **Security Groups**
2. Find `modernpos-db-sg`
3. Add inbound rule:
   - Type: MySQL/Aurora
   - Protocol: TCP
   - Port: 3306
   - Source: `modernpos-web-sg` (EC2 security group)

### Step 3: Import Database
```bash
# Wait for RDS to be available (10-15 minutes)
# Connect from your EC2 instance
mysql -h modernpos-db.xxxxx.us-east-1.rds.amazonaws.com -u admin -p shreshta_collections < shreshta_collections_backup.sql
```

### Step 4: Update Application Configuration
```php
// Update config.php
$sql_details = array(
    'host' => 'modernpos-db.xxxxx.us-east-1.rds.amazonaws.com',
    'db' => 'shreshta_collections',
    'user' => 'admin',
    'pass' => 'YourSecurePassword123!',
    'port' => '3306'
);

define('ROOT_URL', 'http://your-load-balancer-url/');
```

---

## Application Deployment

### Step 1: Test Local Connection
```bash
# Test database connection from EC2
mysql -h modernpos-db.xxxxx.us-east-1.rds.amazonaws.com -u admin -p -e "SHOW DATABASES;"
```

### Step 2: Configure Application Settings
```bash
# Create health check file
sudo tee /var/www/html/health-check.php > /dev/null <<EOF
<?php
try {
    // Database connection test
    $pdo = new PDO("mysql:host=modernpos-db.xxxxx.us-east-1.rds.amazonaws.com;dbname=shreshta_collections", "admin", "YourSecurePassword123!");
    echo "Database: OK\n";
} catch(PDOException $e) {
    http_response_code(500);
    echo "Database: ERROR\n";
}

// Application files test
if (file_exists('/var/www/html/index.php')) {
    echo "Files: OK\n";
} else {
    http_response_code(500);
    echo "Files: ERROR\n";
}
EOF
```

### Step 3: Test Application
```bash
# Visit your EC2 public IP
# You should see your POS login page
curl http://your-ec2-public-ip/
```

---

## Load Balancer Configuration

### Step 1: Create Application Load Balancer
1. Go to **EC2** → **Load Balancers**
2. Click **"Create Load Balancer"**
3. Choose **"Application Load Balancer"**
4. Basic configuration:
   - Name: `modernpos-alb`
   - Scheme: Internet-facing
   - IP address type: IPv4

### Step 2: Configure Network Mapping
- **VPC**: Same as your EC2/RDS
- **Mappings**: Select public subnets in different AZs
- **Security groups**: Create new (`modernpos-alb-sg`)
  - HTTP (80) → 0.0.0.0/0
  - HTTPS (443) → 0.0.0.0/0

### Step 3: Configure Routing
- **Protocol**: HTTP:80
- **Default action**: Forward to target group

### Step 4: Create Target Group
1. **Target type**: Instances
2. **Protocol**: HTTP
3. **Port**: 80
4. **VPC**: Same as before
5. **Health checks**:
   - Health check path: `/health-check.php`
   - Healthy threshold: 2
   - Unhealthy threshold: 2
   - Timeout: 5 seconds
   - Interval: 30 seconds

### Step 5: Register Targets
- Select your EC2 instance
- Click **"Include as pending below"**
- Click **"Register targets"**

---

## Auto Scaling Setup

### Step 1: Create Launch Template
1. Go to **EC2** → **Launch Templates**
2. Click **"Create launch template"**
3. Template details:
   - Name: `modernpos-template`
   - AMI: Choose your current EC2 AMI
   - Instance type: `t2.micro`
   - Key pair: Your key pair
   - Security groups: `modernpos-web-sg`

### Step 2: Advanced Details
- **IAM instance profile**: Create new role for EC2
- **User data**: Add startup script

```bash
#!/bin/bash
# Install LAMP stack automatically
yum update -y
yum install -y httpd php php-mysqlnd php-fpm php-json php-xml php-mbstring php-zip php-gd
systemctl start httpd
systemctl enable httpd

# Deploy application code (you can use S3 or Git here)
# For now, we'll assume code is pre-baked in AMI
```

### Step 3: Create Auto Scaling Group
1. Go to **EC2** → **Auto Scaling Groups**
2. Click **"Create Auto Scaling group"**
3. Choose launch template
4. Configure group:
   - Name: `modernpos-asg`
   - Launch template: `modernpos-template`
   - VPC: Your VPC
   - Subnets: Public subnets
5. Configure advanced options:
   - Load balancing: Attach to existing load balancer
   - Target groups: `modernpos-tg`
6. Configure group size:
   - Desired capacity: 1
   - Minimum capacity: 1
   - Maximum capacity: 3
7. Enable scaling policies:
   - Target tracking scaling policy
   - Metric: Average CPU utilization
   - Target value: 70%

---

## Domain and SSL Setup

### Step 1: Get Free Subdomain
Your load balancer provides a free subdomain:
```
modernpos-alb-xxxxx.us-east-1.elb.amazonaws.com
```

### Step 2: Custom Domain (Optional)
1. Go to **Route 53** → **Hosted zones**
2. Click **"Create hosted zone"**
3. Enter your domain name
4. Create A record pointing to your load balancer

### Step 3: SSL Certificate
1. Go to **ACM** (AWS Certificate Manager)
2. Click **"Request a certificate"**
3. Enter your domain name
4. Choose **"DNS validation"**
5. Add CNAME records to your DNS
6. Wait for validation (5-10 minutes)

### Step 4: HTTPS Listener
1. Go back to your load balancer
2. Add HTTPS listener (port 443)
3. Select your SSL certificate
4. Forward to target group

### Step 5: Redirect HTTP to HTTPS
Add rule to redirect HTTP traffic to HTTPS

---

## Monitoring and Alerts

### Step 1: CloudWatch Dashboard
1. Go to **CloudWatch** → **Dashboards**
2. Create new dashboard: `modernpos-monitoring`
3. Add widgets for:
   - EC2 CPU utilization
   - RDS CPU utilization
   - Database connections
   - Load balancer requests
   - Error rates

### Step 2: Create Alarms
```bash
# CPU High Alarm
aws cloudwatch put-metric-alarm \
  --alarm-name "modernpos-cpu-high" \
  --alarm-description "CPU utilization is high" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold \
  --evaluation-periods 2

# Database Connections High
aws cloudwatch put-metric-alarm \
  --alarm-name "modernpos-db-connections-high" \
  --alarm-description "Database connections are high" \
  --metric-name DatabaseConnections \
  --namespace AWS/RDS \
  --statistic Maximum \
  --period 300 \
  --threshold 80 \
  --comparison-operator GreaterThanThreshold
```

### Step 3: SNS Notifications
1. Create SNS topic for alerts
2. Subscribe your email
3. Attach alarms to SNS topic

---

## Backup Strategy

### Step 1: RDS Automated Backups
```bash
# Enable automated backups
aws rds modify-db-instance \
  --db-instance-identifier modernpos-db \
  --backup-retention-period 7 \
  --preferred-backup-window "03:00-04:00"
```

### Step 2: Manual Snapshots
```bash
# Create DB snapshot
aws rds create-db-snapshot \
  --db-instance-identifier modernpos-db \
  --db-snapshot-identifier "modernpos-backup-$(date +%Y%m%d)"
```

### Step 3: Application Backups
```bash
# Create S3 bucket for backups
aws s3 mb s3://modernpos-backups

# Upload database backup
aws s3 cp shreshta_collections_backup.sql s3://modernpos-backups/database/

# Upload application files
aws s3 sync /var/www/html s3://modernpos-backups/app/
```

### Step 4: AMI Backup
```bash
# Create AMI of your EC2 instance
aws ec2 create-image \
  --instance-id i-xxxxx \
  --name "modernpos-ami-$(date +%Y%m%d)" \
  --description "Modern POS Application Backup"
```

---

## Cost Analysis

### Free Tier (Months 1-12):
| Service | Cost | Notes |
|---------|------|-------|
| EC2 t2.micro | $0 | 750 hours free |
| RDS db.t2.micro | $0 | 750 hours free |
| EBS 30GB | $0 | 30GB free |
| ELB | $0 | 750 hours free |
| Data Transfer | $0 | 1GB out free |
| **Total** | **$0/month** | Completely free |

### After Free Tier (Month 13+):
| Service | Cost | Notes |
|---------|------|-------|
| EC2 t2.micro | $8.50 | On-demand pricing |
| RDS db.t2.micro | $12.41 | On-demand pricing |
| EBS 30GB | $3.45 | SSD storage |
| ELB | $16.43 | Per LCU-hour |
| Data Transfer | $1-2 | Per GB |
| **Total** | **~$42/month** | With reserved instances: ~$25/month |

### Your $100 Credits:
- **Free Tier**: 12 months ($0)
- **After Free Tier**: ~2.5 months ($62.50)
- **Total Free Period**: **14.5 months**

---

## Troubleshooting

### Application Issues
```bash
# Check Apache status
sudo systemctl status httpd

# Check PHP errors
sudo tail -f /var/log/httpd/modernpos_error.log

# Test database connection
mysql -h modernpos-db.xxxxx.us-east-1.rds.amazonaws.com -u admin -p -e "SELECT 1;"

# Check file permissions
ls -la /var/www/html/
```

### Load Balancer Issues
```bash
# Check target health
aws elbv2 describe-target-health --target-group-arn arn:aws:elasticloadbalancing:region:account:targetgroup/modernpos-tg

# Check load balancer logs
# Enable access logs in S3 bucket
```

### Auto Scaling Issues
```bash
# Check scaling activities
aws autoscaling describe-scaling-activities --auto-scaling-group-name modernpos-asg

# Check launch template
aws ec2 describe-launch-templates --launch-template-names modernpos-template
```

### Database Issues
```bash
# Check RDS status
aws rds describe-db-instances --db-instance-identifier modernpos-db

# Check database logs
aws rds describe-db-log-files --db-instance-identifier modernpos-db

# Test connection
mysql -h modernpos-db.xxxxx.us-east-1.rds.amazonaws.com -u admin -p shreshta_collections -e "SHOW TABLES;"
```

---

## Maintenance

### Daily Tasks
- Monitor CloudWatch dashboards
- Check application logs
- Review error rates
- Verify backup completion

### Weekly Tasks
- Security updates on EC2
- Database performance tuning
- Log rotation
- Storage cleanup

### Monthly Tasks
- Cost analysis and optimization
- Security assessments
- Performance reviews
- Backup testing

### Quarterly Tasks
- Major version updates
- Infrastructure reviews
- Disaster recovery testing
- Compliance checks

---

## Security Best Practices

### Network Security
- Use security groups with minimal access
- Enable VPC flow logs
- Use private subnets for databases
- Implement network ACLs

### Application Security
- Keep PHP and Apache updated
- Use HTTPS everywhere
- Implement proper session management
- Regular security scans

### Database Security
- Use strong passwords
- Enable encryption at rest
- Implement least privilege access
- Regular security patches

### Access Management
- Use IAM roles instead of access keys
- Enable MFA for root account
- Regular credential rotation
- Monitor API calls with CloudTrail

---

## Performance Optimization

### EC2 Optimization
- Choose right instance type
- Use EBS optimized instances
- Implement caching (Redis/ElastiCache)
- Optimize PHP configuration

### Database Optimization
- Use read replicas for heavy reads
- Implement connection pooling
- Optimize queries and indexes
- Monitor slow query logs

### Load Balancer Optimization
- Enable compression
- Use appropriate timeout values
- Implement proper health checks
- Monitor latency metrics

---

## Disaster Recovery

### Backup Strategy
- Automated daily backups
- Cross-region replication
- Regular backup testing
- Point-in-time recovery

### Failover Procedures
- Multi-AZ database setup
- Load balancer automatic failover
- Auto scaling for capacity
- DNS failover options

### Business Continuity
- Documented recovery procedures
- Regular DR drills
- Communication plans
- Alternative hosting options

---

## Support and Resources

### AWS Support
- **Basic Support**: Included (free)
- **Developer Support**: $29/month
- **Business Support**: $100/month
- **Enterprise Support**: Custom pricing

### Learning Resources
- AWS Documentation
- AWS Training
- AWS Blogs
- Community Forums

### Professional Services
- AWS Consulting Partners
- AWS Professional Services
- System Integrators

---

## Next Steps

1. **Immediate Actions**:
   - Create AWS account
   - Launch EC2 and RDS
   - Deploy application
   - Test functionality

2. **Short-term Goals**:
   - Setup monitoring and alerts
   - Configure backups
   - Implement SSL
   - Test auto scaling

3. **Long-term Goals**:
   - Optimize performance
   - Implement advanced security
   - Setup CI/CD pipeline
   - Consider multi-region deployment

---

## Contact Information

For support with this deployment:
- AWS Support Center
- AWS Documentation
- Community Forums
- Professional Services

---

*This guide was created for deploying Modern POS system on AWS with zero-downtime architecture. Last updated: September 2025*
