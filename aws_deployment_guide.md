# AWS Lightsail Deployment Guide for Modern POS

## Prerequisites
- AWS Account (free to create)
- Your current Modern POS code
- Database backup (shreshta_collections.sql)

## Step 1: Create AWS Account
1. Go to https://aws.amazon.com
2. Click "Create an AWS Account"
3. Use your email and create password
4. Add payment method (won't be charged for free tier)
5. Verify phone number

## Step 2: Launch Lightsail Instance
1. Go to AWS Lightsail console
2. Click "Create instance"
3. Choose:
   - **Platform**: Linux/Unix
   - **Blueprint**: LAMP (PHP 8.1, MySQL, Apache)
   - **Instance plan**: $5/month (free for 1 month)
   - **Instance name**: modernpos-app
   - **Availability zone**: Choose closest to your users

4. Click "Create instance"
5. Wait 2-3 minutes for setup

## Step 3: Connect to Your Instance
1. In Lightsail console, click your instance
2. Go to "Connect" tab
3. Click "Connect using SSH"
4. This opens a browser-based terminal

## Step 4: Upload Your Code
### Method A: Using Git (Recommended)
```bash
# In the SSH terminal
cd /var/www/html
sudo rm -rf *
sudo git clone https://github.com/yourusername/modernpos.git .
# Or upload your code via SFTP
```

### Method B: Using SFTP
1. Download WinSCP or FileZilla
2. Connect using:
   - Host: Your instance public IP
   - Username: bitnami
   - Password: (get from Lightsail console)
   - Port: 22

## Step 5: Setup Database
```bash
# Connect to MySQL
sudo mysql -u root -p
# Password is in Lightsail console

# Create database
CREATE DATABASE shreshta_collections;
USE shreshta_collections;

# Import your database
source /path/to/shreshta_collections.sql;
```

## Step 6: Configure Your App
1. Edit config.php:
```php
$sql_details = array(
    'host' => 'localhost',
    'db' => 'shreshta_collections',
    'user' => 'root',
    'pass' => 'your_mysql_password',
    'port' => '3306'
);

define('ROOT_URL', 'http://your-instance-ip/');
```

2. Set proper permissions:
```bash
sudo chown -R bitnami:bitnami /var/www/html
sudo chmod -R 755 /var/www/html
sudo chmod -R 777 /var/www/html/storage
```

## Step 7: Setup Custom Domain (Optional)
1. In Lightsail, go to "Networking" tab
2. Add custom domain: `yourdomain.com`
3. Update DNS records at your domain registrar
4. SSL certificate will be auto-generated

## Step 8: Configure Firewall
1. In Lightsail console, go to "Networking" tab
2. Add custom rules:
   - HTTP (port 80) - Any IP
   - HTTPS (port 443) - Any IP
   - SSH (port 22) - Your IP only

## Step 9: Test Your Application
1. Visit: `http://your-instance-ip/`
2. You should see your Modern POS login page
3. Test all major functions

## Step 10: Setup Automatic Backups
1. In Lightsail console, go to "Snapshots" tab
2. Enable automatic daily snapshots
3. Set retention period (7-30 days)

## Cost Breakdown
- **Month 1**: FREE
- **Month 2+**: $5/month for server + $1/month for snapshots
- **Total**: ~$6/month

## Security Best Practices
1. Change default MySQL password
2. Update all default passwords
3. Enable firewall rules
4. Regular security updates
5. Monitor access logs

## Troubleshooting
- **Can't access site**: Check firewall rules
- **Database errors**: Check MySQL service status
- **Permission errors**: Fix file ownership
- **SSL issues**: Wait 24-48 hours for certificate

## Next Steps
1. Setup monitoring
2. Configure email settings
3. Setup automated backups
4. Consider scaling options
