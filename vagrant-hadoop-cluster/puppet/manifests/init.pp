# Copyright (c) 2015 Ken Wu
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#
# -----------------------------------------------------------------------------
#
# Author: Ken Wu
# Date: Apr 2015
# URL: https://github.com/wwken


file { '/etc/profile.d/java_home.sh':
	content => "export JAVA_HOME=$(readlink -f /usr/bin/java | sed 's:bin/java::')",
	owner => 0,
	group => 0,
	mode => 0774,
	require => Package['openjdk-7-jdk']
}


$dependencies = [ 
  #'curl', 
  #'libjansi-java', 
  #'maven', 
  #'scala', 
  #'git', 
  'openjdk-7-jdk'
] 
package { $dependencies: ensure => 'present' }


include apt
apt::source {'cdh5':
  location  => 'http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh',
  release => 'trusty-cdh5.5',
  repos   => 'contrib',
  architecture  => 'amd64',
  include_src   => false,
  key     => '02A818DD',
  key_server  => 'keys.gnupg.net'                                                    
} 

#Install the hadoop
class my::hadoop {

    # create hadoop directory
    $hadoop_data_dirs = [ "/var/lib/hadoop", "/var/lib/hadoop/data" ]
    file { $hadoop_data_dirs:
      ensure    => "directory",
      #owner     => "hdfs",
      #group     => "hadoop",
      #mode      => 0750,
    }
    class { 'cdh::hadoop':
        # Logical Hadoop cluster name.
        cluster_name       => 'mycluster',
        # Must pass an array of hosts here, even if you are
        # not using HA and only have a single NameNode.
        namenode_hosts     => ["hadoop-master"],
        datanode_mounts    => [
            '/var/lib/hadoop/data/a',
            '/var/lib/hadoop/data/b',
            '/var/lib/hadoop/data/c'
        ],
        # You can also provide an array of dfs_name_dirs.
        dfs_name_dir       => '/var/lib/hadoop/name',
    }
    Apt::Source['cdh5'] -> Class['cdh::hadoop']
}

class my::hadoop::worker inherits my::hadoop {
    include cdh::hadoop::worker
}

class my::hadoop::master inherits my::hadoop {
    include cdh::hadoop::master
}

node /^hadoop-node\d+$/ {
    include my::hadoop::worker
}

node 'hadoop-master' {
    include my::hadoop::master
}



