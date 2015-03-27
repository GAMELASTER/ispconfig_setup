# README #

This is a system to automate the installation of ISPConfig 3 
control Panel ( http://www.ispconfig.org/page/home.html ).

For now it is tested and developed only on Debian systems.

Maybe it works well also on Ubuntu systems.

### What is this repository for? ###

This repository contains some scripts for the automation

of installation of ISPConfig 3 control panel.

For now it's composed of two main scritps

- ispc3sysinstall.sh = is the main scritps wich will do a default install
		       based on the https://www.howtoforge.com/perfect-server-debian-wheezy-apache2-bind-dovecot-ispconfig-3
- ispc3_postinstall.sh = is a collection of configuration files, fixed up to work with some enviroment,
			     and needed to fix some issue on normal installation files, provided by debian repository

### How do I get set up? ###

* Summary of set up

First of all follow the guide 

https://www.howtoforge.com/perfect-server-debian-wheezy-apache2-bind-dovecot-ispconfig-3

to install debian as required for ISPConfig

* Configuration

After you got a fresh and perfect Debian installation you can launch the first script

- ./ispc3sysinstall.sh

Follow the instruction on the screen

After that launch 

- ./ispc3_postinstall.sh 

for postinstall fixup.

### Who had contributed to this work? ###

* The scripts and instructions have been produced by Matteo Temporini(<temporini.matteo@gmail.com>)
* The code is based on the "Automatic Debian System Installation for ISPConfig 3" of Author: Mark Stunnenberg <mark@e-rave.nl>