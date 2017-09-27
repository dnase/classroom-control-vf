class nginx{
package{ 'nginx':
   ensure=>present,
}
file{'/var/www':
   ensure => directory,
   //owner => 'root',
   //group => 'root',
   //mode => '0775',
}
file{'nginx.conf':
   ensure=>file,
   path=>'/etc/nginx/nginx.conf'
   source=>'puppet:///modules/nginx/nginx.conf',
   require => Package['nginx'],
   notify => Service['nginx'],
}
file{ 'default.conf':
   ensure=>file,
   path=>'/etc/nginx/conf.d/default.conf'
   source=>'puppet:///modules/nginx/default.conf',
   require => Package['nginx'],
   notify => Service['nginx'],
}
service { 'nginx':
   ensure => running,
   enable => true,
   subscribe=> File['nginx.conf','default.conf'],
}   
file{'/var/www/index.html':
   ensure=>file,
   source=>'puppet:///modules/nginx/index.html',
}
}
