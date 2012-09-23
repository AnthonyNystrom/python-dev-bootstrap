## DESCRIPTION

Complete Python Development Environment on top of a Vagrant VM. Inlcudes GUI support.



## REQUIREMENTS


* [VirtualBox](http://www.virtualbox.org/)
* [VirtualBox Extension Pack](http://download.virtualbox.org/virtualbox/4.2.0/Oracle_VM_VirtualBox_Extension_Pack-4.2.0-80737.vbox-extpack)
* [Vagrant](http://www.vagrantup.com/)
* [git](http://git-scm.com/downloads)
or one of the Github GUI clients: [OSX](http://mac.github.com/), [Windows] (http://windows.github.com/), [Eclipse](http://eclipse.github.com/)
* [python-dev-bootstrap](https://github.com/AnthonyNystrom/python-dev-bootstrap)

		Clone this repo: $ git clone git@github.com:AnthonyNystrom/python-dev-bootstrap.git
		Or, using one of the Github GUI clients, click the button: Clone in {platform}

## BASIC USAGE

1. Assuming you have met the above requirements. 
2. Provision a new Vagrant VM (using PythonDevBootstrap as example)

        $ vagrant box add PythonDevBootstrap http://files.vagrantup.com/lucid32.box
        $ cd python-dev-bootstrap (Wherever your cloned path is for this repo)
        $ vagrant up
 		$ vagrant ssh - (Not required for GUI mode)
 		$ sudo su (Gets you to root) :) - (Not required for GUI mode)
 		
3. GUI Mode (In GUI mode, the CLI will open along side your terminal. Once the provisioning is complete in your terminal window you will see $ prompt) Continue below:

		$ vagrant up
		$ Login: vagrant
		$ Pass: vagrant
		$ startx

 		
The above will build a 512MB virtual machine running Ubuntu with the following installed and configured:

1. Python
2. PIL
3. PIP
4. SciPy
5. BioPy
5. Redis, MongoDB, Postgres, MySQL, Elastic Search
6. Django
7. SQLAlchemy
8. Bottle
9. Twisted
10. Vim
11. IDLE
12. gEdit
13. SublimeText2
14. Pyes
15. POW (Python on Wheels) & Dep...
16. pyQt
17. NumPy
18. numarray
19. matplotlib
20. scrape
21. Beautiful Soup
22. pythonweb
23. mechanize

## NOTES

	1. If you would like to disable GUI support. Remove the following line from
	Vagrantfile: 
	
	config.vm.boot_mode = :gui
	
## OTHER

You can download different types of "boxes" as your base at the following URL:

http://www.vagrantbox.es/

--------------------------------------------------------------------- 
Maintained by [Anthony Nystrom](https://github.com/AnthonyNystrom)
