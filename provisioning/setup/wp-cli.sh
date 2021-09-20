#!/bin/sh

# Set output text color variables
green='\033[0;31m'
red='\033[0;31m'
nc='\033[0m' # No Color

# Install wp-cli:q
FILE=/usr/local/bin/wp
if test -f "$FILE"; then
    echo "${green}wp-cli already installed.${nc}"
else
    echo "Installing wp-cli:"
    if curl -so wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; then
        echo 'wp-cli.phar downloaded.'
        chmod +x wp-cli.phar
        sudo mv wp-cli.phar /usr/local/bin/wp
        curl -so wp-completion.bash https://raw.githubusercontent.com/wp-cli/wp-cli/master/utils/wp-completion.bash
        cat /home/vagrant/wp-completion.bash >> ~/.bashrc
        rm wp-completion.bash
    else
        printf 'Curl failed with error code "%d" (check the manual)\n' "$?" >&2
        exit 1
    fi
fi
