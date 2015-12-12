$extra_str = "done today"

file { 'moftheday':
  path => '/etc/motd',
  content => "Welcomessssssss to your Vagrant-built virtual machine!
              Managed by Puppet on $::hostname $extra_str\n",
  owner   => 0,
  group   => 0,
  mode    => 0644
}

file { '/etc/moftheday':
	target => '/etc/motd',
	require => File['moftheday']
}

file { '/etc/profile.d/java_home.sh':
	content => "export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:bin/java::')",
	owner => 0,
	group => 0,
	mode => 0774,
	require => Package['openjdk-7-jdk']
}

$package_http_server = $::operatingsystem ? {
      /(?i:Ubuntu|Debian|Mint)/ => 'apache2',
      default                   => 'httpd',
    }

$dependencies = [ 'curl', 'libjansi-java', 'openjdk-7-jdk', 'scala', 'git', 'maven', $package_http_server] 
package { $dependencies: ensure => 'present' }




#Install the hadoop
