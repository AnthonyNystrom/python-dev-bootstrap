import "sql.pp"

class general{
  
    exec { "apt-update":
      command => "/usr/bin/sudo apt-get -y update"
    }
  
    package { 
      [ "vim", "git-core", "python", "python-setuptools", "python-dev", "python-twisted", "python-pip", "python-matplotlib",
        "build-essential", "python-imaging", "python-numpy", "python-scipy", "python-software-properties", "idle", "python-qt4"]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "bottle":
      command => "/usr/bin/sudo pip install bottle",
      require => Package["python-dev", "python-pip"]
    }

    exec{
      "biopy":
      command => "/usr/bin/sudo pip install http://biopy.googlecode.com/files/biopy-0.1.7.tar.gz",
      require => Package["python-numpy", "python-dev", "python-scipy", "python-pip"]
    }
    
    exec {
      "sqlalchemy":
      command => "/usr/bin/sudo pip install sqlalchemy",
      require => Package["python-pip"],
    }

    exec {
      "django":
      command => "/usr/bin/sudo pip install django",
      require => Package["python-pip"],
    }

    exec {
      "beautifulsoup4":
      command => "/usr/bin/sudo pip install beautifulsoup4",
      require => Package["python-pip"]
    }

    exec {
      "mechanize":
      command => "/usr/bin/sudo pip install mechanize",
      require => Package["python-pip"]
    }

    exec {
      "numarray":
      command => "/usr/bin/sudo easy_install http://downloads.sourceforge.net/project/numpy/Old%20Numarray/1.5.2/numarray-1.5.2.tar.gz",
      require => Package["python-setuptools"]
    }
    
    exec {
      "scrapelib":
      command => "/usr/bin/sudo pip install scrapelib",
      require => Package["python-pip"]
    }

    exec {
      "Pyes":
      command => "/usr/bin/sudo pip install Pyes",
      require => Package["python-pip"]
    }



#PythonOnWheels

    exec {
      "WebOb":
      command => "/usr/bin/sudo pip install WebOb",
      require => Package["python-pip"]
    }

    exec {
      "Mako":
      command => "/usr/bin/sudo pip install Mako",
      require => Package["python-pip"]
    }

    exec {
      "Beaker":
      command => "/usr/bin/sudo pip install Beaker",
      require => Package["python-pip"]
    }

    exec {
      "Nose":
      command => "/usr/bin/sudo pip install Nose",
      require => Package["python-pip"]
    }
    
    exec {
      "pow_devel":
      command => "/bin/true && cd /home/vagrant/ && /usr/bin/git clone https://github.com/pythononwheels/pow_devel.git && chown vagrant.vagrant -R pow_devel",
      require => [Package["git-core"], Exec["WebOb"], Exec["Mako"], Exec["Beaker"], Exec["Nose"]],
      onlyif => "/bin/true && test ! -d /home/vagrant/pow_devel"
    }
    
    exec {
      "pythonweb":
      command => "/bin/rm -f /tmp/PythonWeb.org-0.5.3-src.tar.gz && cd /tmp && /usr/bin/wget http://pythonweb.org/projects/webmodules/release/0.5.3/PythonWeb.org-0.5.3-src.tar.gz && /bin/tar xzf /tmp/PythonWeb.org-0.5.3-src.tar.gz && cd /tmp/PythonWeb.org/ && (echo y && echo y && yes '') | /usr/bin/sudo python setup.py install",
      require => Package["python"],
    }
    
}


class gui{

  exec { "apt-update-gui":
    command => "/usr/bin/sudo apt-get -y update"
  }
  
  package{
    "ubuntu-desktop":
    ensure => ["installed"],
    require => Exec['apt-update-gui'],
  }
  
  exec {
    "gedit":
    command => "/usr/bin/sudo apt-get install gedit",
    require => Package["ubuntu-desktop"]
  }
  
  exec {
    "repo":
    command => "/usr/bin/sudo add-apt-repository ppa:webupd8team/sublime-text-2 && /usr/bin/sudo apt-get -y update",
    require => Package["python-software-properties"]
  }
  
  exec {
    "sublime-text":
    command => "/usr/bin/sudo apt-get install sublime-text",
    require => Exec["repo"]
  }
  
}

include general
include sql
include mongodb
include elasticsearch
include gui


