This vagrant-puppet module installs and setup Apache Spark cluster with Hadoop and other dependencies.  It is based on the <a href="https://github.com/apache/bigtop" target="_blank">Apache Bigtop</a> repo and makes some customizations.  It has been fully tested on the Mac-OX environment.  It should be working the same on any Windows environment as well.

### Getting Started 
- Clone this repo to your local directory, say github,first.
```bash
git clone https://github.com/wwken/Vagrant-Puppet.git ~/github
```

- Please make sure to finish the <a href="https://github.com/wwken/Vagrant-Puppet#prerequisite" target="_blank">prerequisite</a> part first to install all required softwares/components.

- After the prerequisities are done, on the project home folder (e.g. /Users/ken/github/Vagrant-Puppet) run the following command to bring up the spark cluster

```bash
./vagrant-spark-cluster/vagrant up
```

By default, it will create one master and two worker nodes in which the Spark instance is running on

- Now do the vagrant status command to make sure the three virtual instances are created sucessfully

```bash
./vagrant-spark-cluster/vagrant status
```

![Alt text](demo/spark1.png?raw=true "Spark instances created")

- Now vagrant ssh into the master node to run any spark job

```bash
./vagrant-spark-cluster/vagrant ssh spark-master
```

You will now log in the spark-master node, no run the spark-shell command and u will see the spark-shell
```bash
[vagrant@spark1 ~]$ sudo su - hdfs spark-shell
```


![Alt text](demo/spark2.png?raw=true "Spark Shell")

### Optional - Playing with the Spark Cluster
- You can now follow the <a href="http://spark.apache.org/docs/latest/quick-start.html" target="_blank">Spark offical tutorial</a> to run the hello world in this Spark cluster, for example, you can do something like this:

Now u can run the SparkPi program from the tutorial:
```bash
[vagrant@spark1 ~]$ /usr/lib/spark/bin/run-example SparkPi
```

![Alt text](demo/spark3.png?raw=true "SparkPi program output")


Notice that the hdfs is running already and you can put something dummy stuffs into the the hdfs system, such as /tmp/
```bash
[vagrant@spark1 ~]$ hadoop fs -put /etc/spark/conf/spark-env.sh /tmp/
[vagrant@spark1 ~]$ hadoop fs -ls /tmp/
```

![Alt text](demo/spark4.png?raw=true "hdfs import")
