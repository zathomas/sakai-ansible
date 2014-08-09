     ____        _         _      _              _ _     _      
    / ___|  __ _| | ____ _(_)    / \   _ __  ___(_) |__ | | ___ 
    \___ \ / _` | |/ / _` | |   / _ \ | '_ \/ __| | '_ \| |/ _ \
     ___) | (_| |   < (_| | |  / ___ \| | | \__ \ | |_) | |  __/
    |____/ \__,_|_|\_\__,_|_| /_/   \_\_| |_|___/_|_.__/|_|\___|

    git clone https://github.com/zathomas/sakai-ansible
    cd sakai-ansible
    vagrant up

[Ansible](http://www.ansible.com) is a tool for automating server provisioning and configuration. [Vagrant](http://www.vagrantup.com) is a front-end for setting up virtual machines on your local desktop. Together, they can be used to specify and run software development environments. There are a few dependencies: these instructions assume you have ruby, python, git, ansible, vagrant, and the latest version of Oracle's [VirtualBox](https://www.virtualbox.org/wiki/Downloads).

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

All the initial configuration is done for you. The files that contribute to the config are in the `files` directories beneath each role in the `roles` directory.

## Maven config
* `maven.sh` sets a couple of memory options for maven
* `settings.xml` sets the location of the local maven repository and the tomcat home

## Tomcat config
* `setenv.sh` sets JVM options for Tomcat, like setting memory sizes and enabling the debugger
* `sakai.properties` is most of the configuration that Sakai uses
* `catalina.properties` tells Tomcat 7 how to load Sakai classes

You can make any tweaks you want, then run this command (from the `sakai-ansible` directory of your host machine) to update your VM:

    vagrant provision

> NOTE: every time you provision, the `source` role wants to do an `svn update`. This is time-consuming and you probably don't want to keep doing it. To put this update on ice, comment out the `source` role from the `dev-sakai.yml` file before you run `vagrant provision`.

# Build and Run
Once the VM is running, it's ready to build and deploy Sakai. Assuming you've already logged in with `vagrant ssh`:

    cd /vagrant/sakai-src
    mvn clean install sakai:deploy
    sudo service tomcat start
    # watch the log on startup
    tail -f /opt/tomcat-sakai/logs/catalina.out

It uses `/vagrant/maven-repo` as the local Maven repository. The reason for this is that you should be able to blow away the VM at any time without having to download everything again (All 864MiB of it). That's the same reason we checkout the source code to `/vagrant/sakai-src`. 

Once Tomcat has finished starting up, you can access Sakai on the _host_ machine at http://localhost:8888/portal This works because the VM is configured to forward port 8888 on the host machine to port 8080 on the VM. Likewise, you can attach a debugger to `localhost:5005` because port 5005 is being forwarded to the debugger listener in Tomcat on the VM.

# Motivation
We spend a lot of time setting up servers, tools, various environments. Once you've gotten everything just the way you like it, how easy is it to do it all again? We now have the means to describe in a precise, machine-readable form what our machine should look like. If we need to make a tweak, we tweak the specification, not the machine. Anything that can be automated saves human beings from having to do it.

This repository is very similar to [one I created](https://github.com/zathomas/sakai-vagrant) a little over a year ago using vagrant and [puppet](https://puppetlabs.com/puppet/what-is-puppet/). I switched over to ansible a few months ago because I found it much easier to understand and much quicker to get things working. I'm keeping the puppet version around in case some people prefer it.