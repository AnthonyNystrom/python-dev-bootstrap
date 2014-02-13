import "sql.pp"

class core {
  
    exec { "apt-update":
      command => "/usr/bin/sudo apt-get -y update"
    }
  
    package { 
      [ "vim", "git-core", "build-essential" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
}

class python {

    package { 
      [ "python", "python-setuptools", "python-dev", "python-pip",
        "python-matplotlib", "python-imaging", "python-numpy", "python-scipy",
        "python-software-properties", "idle", "python-qt4", "python-wxgtk2.8" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "virtualenv":
      command => "/usr/bin/sudo pip install virtualenv",
      require => Package["python-dev", "python-pip"]
    }

}

class pythondev {
    package {
        [ "dpkg-dev", "swig", "python2.7-dev", "libwebkitgtk-dev", "libjpeg-dev", "libtiff4-dev",
        "checkinstall", "ubuntu-restricted-extras", "freeglut3", "freeglut3-dev", "libgtk2.0-dev", "libsdl1.2-dev",
        "libgstreamer-plugins-base0.10-dev", "libwxgtk2.8-dev" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "SquareMap":
      command => "/usr/bin/sudo pip install SquareMap",
      require => Package["python-dev", "python-pip"]
    }

    exec {
      "RunSnakeRun":
      command => "/usr/bin/sudo pip install RunSnakeRun",
      require => Package["python-dev", "python-pip"]
    }

    exec {
      "wx-from-source":
      cwd => "/tmp",
      command => "/usr/bin/apt-get source -d wxwidgets2.8 && /usr/bin/dpkg-source -x wxwidgets2.8_2.8.12.1-6ubuntu2.dsc",
      #creates => "/tmp/wxwidgets2.8-2.8.12.1/wxPython",
      creates => '/usr/local/lib/python2.7/dist-packages/wx/lib/__init__.pyc',
      path => "/bin:/usr/bin:/usr/local/bin",

      require => [Exec['apt-update'], Package["python-dev", "python-pip", "dpkg-dev"]]
    }

    exec {
      "compile-wx-from-source":
      cwd => "/tmp/wxwidgets2.8-2.8.12.1/wxPython",
      command => "/usr/bin/sudo python setup.py install",
      creates => '/usr/local/lib/python2.7/dist-packages/wx/lib/__init__.pyc',
      path => '/bin:/usr/bin:/usr/local/bin',

      require => Exec['wx-from-source']
    }
}

class networking {
    package { 
      [ "snmp", "tkmib", "curl", "wget" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }
    
}

class science {

    exec {
      "numarray":
      command => "/usr/bin/sudo easy_install http://downloads.sourceforge.net/project/numpy/Old%20Numarray/1.5.2/numarray-1.5.2.tar.gz",
      require => Package["python-setuptools"]
    }

    exec {
      "biopy":
      command => "/usr/bin/sudo pip install http://biopy.googlecode.com/files/biopy-0.1.7.tar.gz",
      require => Package["python-numpy", "python-dev", "python-scipy", "python-pip"]
    }
}

class web {

    package { 
      [ "python-twisted" ]:
        ensure => ["installed"],
        require => Exec['apt-update']    
    }

    exec {
      "bottle":
      command => "/usr/bin/sudo pip install bottle",
      require => Package["python-dev", "python-pip"]
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
      "scrapelib":
      command => "/usr/bin/sudo pip install scrapelib",
      require => Package["python-pip"]
    }

    exec {
      "Pyes":
      command => "/usr/bin/sudo pip install Pyes",
      require => Package["python-pip"]
    }

}

class pythononwheels {

    exec {
      "WebOb":
      command => "/usr/bin/sudo pip install WebOb",
      require => Package["python-pip"],
    }

    exec {
      "Mako":
      command => "/usr/bin/sudo pip install Mako",
      require => Package["python-pip"],
    }

    exec {
      "Beaker":
      command => "/usr/bin/sudo pip install Beaker",
      require => Package["python-pip"],
    }

    exec {
      "Nose":
      command => "/usr/bin/sudo pip install Nose",
      require => Package["python-pip"],
    }
    
    exec {
      "pow_devel":
      command => "/bin/true && cd /home/vagrant/ && /usr/bin/git clone https://github.com/pythononwheels/pow_devel.git && chown vagrant.vagrant -R pow_devel",
      require => [Package["git-core"], Exec["WebOb"], Exec["Mako"], Exec["Beaker"], Exec["Nose"]],
      onlyif => "/bin/true && test ! -d /home/vagrant/pow_devel",
    }
    
    exec {
      "pythonweb":
      command => "/bin/rm -f /tmp/PythonWeb.org-0.5.3-src.tar.gz && cd /tmp && /usr/bin/wget http://pythonweb.org/projects/webmodules/release/0.5.3/PythonWeb.org-0.5.3-src.tar.gz && /bin/tar xzf /tmp/PythonWeb.org-0.5.3-src.tar.gz && cd /tmp/PythonWeb.org/ && (echo y && echo y && yes '') | /usr/bin/sudo python setup.py install",
      require => Package["python"],
    }
    
}


class gui {

  package {
    "ubuntu-desktop":
    ensure => ["installed"],
  }

  package { 
    [ "vim-gtk" ]:
      ensure => ["installed"],
      require => Package["ubuntu-desktop"]
  }
  
  exec {
    "repo":
    command => "/usr/bin/sudo add-apt-repository ppa:webupd8team/sublime-text-2 && /usr/bin/sudo apt-get -y update",
    require => Package["python-software-properties"],
  }

  package { 
    [ "sublime-text" ]:
      ensure => ["installed"],
      require => [Package["ubuntu-desktop"], Exec["repo"]]
  }
  
}

class keepuptodate {
    
    exec {
        "apt-upgrade":
        command => "/usr/bin/sudo apt-get -y upgrade",
        require => [Package["ubuntu-desktop"], Exec["wx-from-source"]],
    }

}

class flask {

  exec {
    "fabric":
      command => "/usr/bin/sudo pip install Fabric",
      require => Package["python-pip"],
  }

  exec {
    "Flask":
      command => "/usr/bin/sudo pip install Flask",
      require => Package["python-pip"],
  }

  exec {
    "flask-sqlalchemy":
      command => "/usr/bin/sudo pip install Flask-SQLAlchemy",
      require => Package["python-pip"],
  }

  exec {
    "flask-script":
      command => "/usr/bin/sudo pip install Flask-Script",
      require => Package["python-pip"],
  }

  exec {
    "flask-wtforms":
      command => "/usr/bin/sudo pip install Flask-WTF",
      require => Package["python-pip"],
  }

  exec {
    "argparse":
      command => "/usr/bin/sudo pip install argparse",
      require => Package["python-pip"],
  }

  exec {
    "distribute":
      command => "/usr/bin/sudo pip install distribute",
      require => Package["python-pip"],
  }

  exec {
    "pyGeoDB":
      command => "/usr/bin/sudo pip install pyGeoDB",
      require => Package["python-pip"],
  }

  exec {
    "wtforms-recaptcha":
      command => "/usr/bin/sudo pip install wtforms-recaptcha",
      require => Package["python-pip"],
  }

  exec {
    "flup":
      command => "/usr/bin/sudo pip install flup",
      require => Package["python-pip"],
  }

}



include core
include python
include pythondev
include networking
include gui
include keepuptodate
include web
include sql
include mongodb

#include science
#include pythononwheels
#include flask