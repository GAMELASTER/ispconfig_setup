#!/bin/bash
#---------------------------------------------------------------------
# install.sh
#
# ISPConfig 3 system installer
#
# Script: install.sh
# Version: 1.0.5
# Author: Matteo Temporini <temporini.matteo@gmail.com>
# Description: This script will install all the packages needed to install
# ISPConfig 3 on your server.
#
#
#---------------------------------------------------------------------



#---------------------------------------------------------------------
# Global variables
#---------------------------------------------------------------------
CFG_HOSTNAME_FQDN=`hostname -f`;
WT_BACKTITLE="ISPConfig 3 System Installer from Temporini Matteo"

# Bash Colour
red='\033[0;31m'
green='\033[0;32m'
NC='\033[0m' # No Color


#Saving current directory
PWD=$(pwd);

clear

#---------------------------------------------------------------------
# Load needed functions
#---------------------------------------------------------------------

source $PWD/functions/check_linux.sh
CheckLinux
#---------------------------------------------------------------------
# Load needed Modules
#---------------------------------------------------------------------

source $PWD/distros/$DISTRO/install_basics.sh
source $PWD/distros/$DISTRO/preinstallcheck.sh
source $PWD/distros/$DISTRO/askquestions.sh
source $PWD/distros/$DISTRO/install_postfix.sh
source $PWD/distros/$DISTRO/install_mysql.sh
source $PWD/distros/$DISTRO/install_mta.sh
source $PWD/distros/$DISTRO/install_antivirus.sh
source $PWD/distros/$DISTRO/install_webserver.sh
source $PWD/distros/$DISTRO/install_ftp.sh
source $PWD/distros/$DISTRO/install_quota.sh
source $PWD/distros/$DISTRO/install_bind.sh
source $PWD/distros/$DISTRO/install_webstats.sh
source $PWD/distros/$DISTRO/install_jailkit.sh
source $PWD/distros/$DISTRO/install_fail2ban.sh
source $PWD/distros/$DISTRO/install_webmail.sh
source $PWD/distros/$DISTRO/install_ispconfig.sh
source $PWD/distros/$DISTRO/install_fix.sh

#---------------------------------------------------------------------
# Main program [ main() ]
#    Run the installer
#---------------------------------------------------------------------

echo "========================================="
echo "ISPConfig 3 System installer"
echo "========================================="
echo
echo "This script will do a nearly unattended intallation of"
echo "all software needed to run ISPConfig 3."
echo "When this script starts running, it'll keep going all the way"
echo "So before you continue, please make sure the following checklist is ok:"
echo
echo "- This is a clean / standard debian installation";
echo "- Internet connection is working properly";
echo
echo
if [ -n "$PRETTY_NAME" ]; then
	echo -e "The detected Linux Distribution is: " $PRETTY_NAME
else
	echo -e "The detected Linux Distribution is: " $ID-$VERSION_ID
fi
echo
if [ -n "$DISTRO" ]; then
	read -p "Is this correct? (y/n)" -n 1 -r
	echo    # (optional) move to a new line
	if [[ ! $REPLY =~ ^[Yy]$ ]]
		then
		exit 1
	fi
else
	echo -e "Sorry but your System is not supported by this script, if you want your system supported "
	echo -e "open an issue on GitHub: https://github.com/servisys/ispconfig_setup"
	exit 1
fi


if [ -f /etc/debian_version ]; then
  PreInstallCheck
  AskQuestions 
  InstallBasics 2>> /var/log/ispconfig_setup.log
  InstallPostfix 2>> /var/log/ispconfig_setup.log
  InstallSQLServer 2>> /var/log/ispconfig_setup.log
  InstallMTA 2>> /var/log/ispconfig_setup.log
  InstallAntiVirus 2>> /var/log/ispconfig_setup.log
  InstallWebServer
  InstallFTP 2>> /var/log/ispconfig_setup.log
  if [ $CFG_QUOTA == "y" ]; then
	InstallQuota 2>> /var/log/ispconfig_setup.log
  fi
  InstallBind 2>> /var/log/ispconfig_setup.log
  InstallWebStats 2>> /var/log/ispconfig_setup.log
  if [ $CFG_JKIT == "y" ]; then
	InstallJailkit 2>> /var/log/ispconfig_setup.log
  fi
  InstallFail2ban 2>> /var/log/ispconfig_setup.log
  InstallWebmail 2>> /var/log/ispconfig_setup.log
  InstallISPConfig
  InstallFix
  echo -e "${green}Well done ISPConfig installed and configured correctly :D ${NC}"
  echo "Now you can connect to your ISPConfig installation at https://$CFG_HOSTNAME_FQDN:8080 or https://IP_ADDRESS:8080"
  echo "You can visit my GitHub profile at https://github.com/servisys/ispconfig_setup/"
  if [ $CFG_WEBMAIL == "roundcube" ]; then
	echo -e "${red}You had to edit user/pass /var/lib/roundcube/plugins/ispconfig3_account/config/config.inc.php of roudcube user, as the one you inserted in ISPconfig ${NC}"
  fi
  if [ $CFG_WEBSERVER == "nginx" ]; then
  	echo "Phpmyadmin is accessibile at  http://$CFG_HOSTNAME_FQDN:8081/phpmyadmin or http://IP_ADDRESS:8081/phpmyadmin";
	echo "Webmail is accessibile at  http://$CFG_HOSTNAME_FQDN:8081/webmail or http://IP_ADDRESS:8081/webmail";
  fi
else
  echo "${red}Unsupported linux distribution.${NC}"
fi

exit 0

