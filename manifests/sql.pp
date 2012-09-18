
class sql {
  
  exec { "apt-update-repo":
    command => "/usr/bin/apt-get -y update"
  }

  package {
    ["mysql-client", "mysql-server", "libmysqlclient-dev", "redis-server", "postgresql", "postgresql-client"]: 
      ensure => installed, 
      require => Exec['apt-update']
  }
  
  service { "mysql":
    ensure    => running,
    enable    => true,
    require => Package["mysql-server"],  
  }

  service { "redis-server":
    ensure    => running,
    enable    => true,
    require => Package["redis-server"],  
  }

  service { "postgresql-8.4":
    ensure    => running,
    enable    => true,
    require => Package["postgresql"],  
  }
  
}


class mongodb{

  exec { "10gen-apt-key":
    path => "/bin:/usr/bin",
    command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
    unless => "apt-key list | grep 10gen",
  }

  exec { "10gen-apt-repo":
    path => "/bin:/usr/bin",
    command => "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list",
    unless => "cat /etc/apt/sources.list | grep 10gen",
    require => Exec["10gen-apt-key"],
  }

  exec { "10gen-apt-update":
    path => "/bin:/usr/bin",
    command => "apt-get update",
    unless => "ls /usr/bin | grep mongo",
    require => Exec["10gen-apt-repo"],
  }

  package { "mongodb-10gen":
    ensure => installed,
    require => Exec["10gen-apt-update"],
  }

  service { "mongodb":
    enable => true,
    ensure => running,
    require => Package["mongodb-10gen"],
  }

}



