class elasticsearch::params {
  $version = "0.19.9"
  $java_package = "openjdk-6-jre-headless"
  $dbdir = "/var/lib/elasticsearch"
  $logdir = "/var/log/elasticsearch"
}

class elasticsearch(
  $version = $elasticsearch::params::version,
  $java_package = $elasticsearch::params::java_package,
  $dbdir = $elasticsearch::params::dbdir,
  $logdir = $elasticsearch::params::logdir
) inherits elasticsearch::params {
  $tarchive = "elasticsearch-${version}.tar.gz"
  $tmptarchive = "/tmp/${tarchive}"
  $tmpdir = "/tmp/elasticsearch-${version}"
  $sharedirv = "/usr/share/elasticsearch-${version}"
  $sharedir = "/usr/share/elasticsearch"
  $etcdir = "/etc/elasticsearch"
  $upstartfile = "/etc/init/elasticsearch.conf"
  $defaultsfile = "/etc/default/elasticsearch"
  $configfile = "$etcdir/elasticsearch.yml"
  $logconfigfile = "$etcdir/logging.yml"

  if !defined(Package[$java_package]) {
    package { $java_package:
      ensure => installed,
    }
  }

  File {
    before => Service['elasticsearch'],
  }

  group { 'elasticsearch':
    ensure => present,
    system  => true,
  }

  user { 'elasticsearch':
    ensure  => present,
    system  => true,
    home    => $sharedir,
    shell   => '/bin/false',
    gid     => 'elasticsearch',
    require => Group['elasticsearch'],
  }

  file { $dbdir:
    ensure  => directory,
    owner   => 'elasticsearch',
    group   => 'elasticsearch',
    mode    => '0755',
    require => User['elasticsearch'],
  }

  file { $logdir:
    ensure  => directory,
    owner   => 'elasticsearch',
    group   => 'elasticsearch',
    mode    => '0755',
    require => User['elasticsearch'],
  }

  file { $tmptarchive:
    ensure  => present,
    source  => "puppet:///modules/elasticsearch/${tarchive}",
    owner   => 'elasticsearch',
    mode    => '0644',
  }

  exec { $tmpdir:
    command => "/bin/tar xzf ${tmptarchive}",
    cwd     => "/tmp",
    creates => $tmpdir,
    require => File[$tmptarchive],
  }

  exec { $sharedirv:
    command => "find . -type f | xargs -i{} install -D {} ${sharedirv}/{}",
    cwd     => $tmpdir,
    path    => "/bin:/usr/bin",
    creates => $sharedirv,
    require => Exec[$tmpdir],
  }

  file { $sharedir:
    ensure  => link,
    target  => $sharedirv,
    require => Exec[$sharedirv],
  }

  file { "$sharedir/elasticsearch.in.sh":
    ensure  => link,
    target  => "$sharedir/bin/elasticsearch.in.sh",
    require => File[$sharedir],
  }

  file { "/usr/bin/elasticsearch":
    ensure => link,
    target => "$sharedirv/bin/elasticsearch",
    require => Exec[$sharedirv],
  }

  file { $etcdir:
    ensure => directory
  }

  file { $configfile:
    ensure => present,
    source => ["puppet:///modules/elasticsearch/elasticsearch.yml"],
    owner  => root,
    group  => root,
  }

  file { $logconfigfile:
    ensure => present,
    source => ["puppet:///modules/elasticsearch/logging.yml"],
    owner  => root,
    group  => root,
  }

  file { $defaultsfile:
    ensure => present,
    source => "puppet:///modules/elasticsearch/etc-default-elasticsearch",
  }

  file { $upstartfile:
    ensure => present,
    source => "puppet:///modules/elasticsearch/etc-init-elasticsearch.conf",
  }

#  service { 'elasticsearch':
#    ensure   => running, 
#    enable   => true,
#    provider => upstart,
#  }
  
  file { '/etc/init.d/elasticsearch':
    ensure => link,
    target => "/lib/init/upstart-job",
  }

  service { 'elasticsearch':
    ensure        => running, 
    hasrestart    => true,
    hasstatus     => true,
    provider      => 'upstart',
    subscribe     => [ File[$upstartfile], File['/etc/init.d/elasticsearch'] ],
  }

}
