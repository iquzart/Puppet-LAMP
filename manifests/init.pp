# Class: lamp
# ===========================
#
# Full description of class lamp here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'lamp':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class lamp (

$apache_pkg = $::lamp::params::apache_pkg, 
$mysql_pkg = $::lamp::params::mysql_pkg,
$mysql_service = $::lamp::params::mysql_service,
$mysqlpassword = $::lamp::params::mysqlpassword,
$php_pkg = $::lamp::params::php_pkg,
$php_enhancers = $::lamp::params::php_enhancers,
) inherits ::lamp::params {

# Apache

  package { 'apache-package':
    name    => $apache_pkg,
    ensure  => installed,
   }

  service { 'apache-service':
    name    => $apache_pkg,
    enable   => true,
    ensure   => running,
    require   => Package['apache-package'],
  }


# MySQL
 
  package { 'mysql-package':
    name    => $mysql_pkg,
    ensure  => installed,
  }

  service { 'mysql-service':
    name      => $mysql_service,
    ensure    => running,
    enable    => true,
    require   => Package['mysql-package'],
  }
  
  exec { 'set-mysql-password':
    unless => "mysqladmin -uroot -p\'$mysqlpassword\' status",
    path => ['/bin', '/usr/bin'],
    command => "mysqladmin -uroot password \'$mysqlpassword\'",
    require => Service['mysql-service'],
  }

# PHP
 
  package { 'php':
    name    => $php_pkg,
    ensure  => present,
  }

  package { 'php-enhancers':
    name    => $php_enhancers,
    ensure  => present,
  }


}
