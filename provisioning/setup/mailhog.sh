#!/bin/sh

# Install go
sudo apt-get -y install golang-go

# added a line to our profile to set the $GOPATH variable
echo "export GOPATH=$HOME/gocode" >> ~/.profile

# Create folder
mkdir gocode

# Get MailHog from github with go
go get github.com/mailhog/MailHog

# Get mhsendmail from github with go
go get github.com/mailhog/mhsendmail

# Copy them to local
sudo mv /root/gocode/bin/MailHog /usr/local/bin/mailhog
sudo mv /root/gocode/bin/mhsendmail /usr/local/bin/mhsendmail

# Create Servicefile
sudo touch /etc/systemd/system/mailhog.service

# Fill Servicefile
sudo echo "[Unit]
      Description=MailHog service

      [Service]
      ExecStart=/usr/local/bin/mailhog \
        -api-bind-addr 192.168.33.11:8025 \
        -ui-bind-addr 192.168.33.11:8025 \
        -smtp-bind-addr 127.0.0.1:1025

      [Install]
      WantedBy=multi-user.target" >> /etc/systemd/system/mailhog.service


# Start mailhog service
sudo systemctl start mailhog

# @TODO: Check if enabled on boot
sudo systemctl enable mailhog

# Check if running
systemctl | grep mailhog

# Change sendmail path
# @TODO: All PHP Versions
# sudo sed -e '/^[^;]*sendmail_path/s/=.*$/= \/usr\/bin\/msmtp -t/' -i.bak /etc/php5/apache2/php.ini

# Start manually
# mailhog   -api-bind-addr 192.168.33.11:8025   -ui-bind-addr 192.168.33.11:8025   -smtp-bind-addr 127.0.0.1:1025
