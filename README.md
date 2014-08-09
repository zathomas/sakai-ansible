     ____        _         _      _              _ _     _      
    / ___|  __ _| | ____ _(_)    / \   _ __  ___(_) |__ | | ___ 
    \___ \ / _` | |/ / _` | |   / _ \ | '_ \/ __| | '_ \| |/ _ \
     ___) | (_| |   < (_| | |  / ___ \| | | \__ \ | |_) | |  __/
    |____/ \__,_|_|\_\__,_|_| /_/   \_\_| |_|___/_|_.__/|_|\___|

    git clone https://github.com/zathomas/sakai-ansible
    cd sakai-ansible
    vagrant up

[Ansible](http://www.ansible.com) is a tool for automating server provisioning and configuration. [Vagrant](http://www.vagrantup.com) is a front-end for setting up virtual machines on your local desktop. Together, they can be used to specify and run software development environments. There a few dependencies: these instructions assume you have ruby, python, git, ansible, vagrant, and the latest version of Oracle's [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

The very first time you start this VM, it’s going to download a base CentOS server image, install the necessary tools and then checkout the Sakai source code. Once it’s underway, this is a good time to go get lunch. The source code is close to 500MiB, and Subversion takes its sweet time. You can check on how it's doing from time to time by opening a second terminal and measuring the size of the source directory, like this: `du -hs sakai-ansible/sakai-src`

When it's finished, you can connect to the new VM like this:

    vagrant ssh

# What's Included
The system you'll end up with is very close to what's described in the [developer setup documentation](https://confluence.sakaiproject.org/display/BOOT/Development+Environment+Setup+Walkthrough) from the Sakai Project. Specifically, you get:

* Java (SDK)
* Subversion for version control
* Maven for build, test, and deploy
* Tomcat for the runtime container
* MySQL for the dabase backend
* Everything else that usually comes with a CentOS 6 server

One thing I _didn't_ bother to include is Eclipse and the extras that you'd use with it, because Vagrant creates headless machines, and any IDE that you decide to use will still be run from your host machine.
