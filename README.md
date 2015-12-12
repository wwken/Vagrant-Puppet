It is never too easy to spin off a test hadoop, spark or hive cluster with few nodes virtually on your local computer!  I have provided few Vagrant-puppet modules for you to do it yourself.  To try any of the modules, please make sure you have these:

##### Prerequisit:

1) download VirtualBox first at: https://www.virtualbox.org/wiki/Downloads and install it.
2) download a version of Vagrant that suits your machine at here: https://www.vagrantup.com/downloads.html and install it.
3) run these commands: 

vagrant plugin install puppet
vagrant plugin install vagrant-puppet-install


##### Blog:
https://wwken.wordpress.com/2015/03/21/setting-up-a-virtual-machine-locally-using-vagrant-and-puppet-1/
https://wwken.wordpress.com/2015/04/04/setting-up-a-multiple-virtual-nodes-cluster-and-running-hadoop-on-top-of-it-using-vagrant-and-puppet/