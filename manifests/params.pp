class lamp::params {

# Apache
$apache_pkg = $operatingsystem ? {
    /RedHat|CentOS/ => 'httpd',
    /Debian|Ubuntu/ => 'apache2',
  }


# MySQL
$mysqlpassword = "System@12"

  if $::osfamily == 'RedHat' {
    $mysql_pkg     = 'mariadb-server'
    $mysql_service  = 'mariadb'
    $init_cmd       = '/bin/true'
    $mysqlpwd_cmd   = '/usr/bin/mysqladmin -u root password $mysqlpassword || /bin/true'
  }

  elsif $::osfamily == 'Debian' {
    $mysql_pkg     = 'mariadb-server'
    $mysql_service  = 'mysql'
    $init_cmd       = '/sbin/initctl reload-configuration'
    $mysqlpwd_cmd   = '/usr/bin/mysqladmin -u root password $mysqlpassword || /bin/true'
  }

  else {
    fail('Unsupported Linux Distribution')
  }


# PHP 
 $php_pkg = $osfamily ? {
    'Debian'    => 'php5',
    'RedHat'    => 'php',
  }

 if $::osfamily == 'RedHat' {
 $php_enhancers = 'php-pear'
 }

 elsif $::osfamily == 'Debian' { 
 $php_enhancers = 'php-pear'
 }
 else {
   fail('Unsupported Linux Distribution')
 }

}
