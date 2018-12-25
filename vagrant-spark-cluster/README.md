# spark_cluster_vagrant #
Vagrant template to provision a standalone Spark cluster with lean defaults. This is a great way to set up a Spark cluster on your laptop that can easily be deleted later with no changes to your machine.

# Details #

- See `Vagrantfile` for details and to make changes.
- Spark running as a standalone cluster. Tested with Spark 2.1.x and 2.2.x.
- One head node Ubuntu 16.04 machine and `N` worker (slave) machines.
- Spark running in standalone cluster mode.

# Usage #

To spin up your own local Spark cluster, clone this repository first.

Next, [download a pre-built Spark package](https://spark.apache.org/downloads.html) and place it into this directory, named "spark.tgz".

Next, open up `Vagrantfile` in a text editor.

You'll want to change the `N_WORKERS` variable near the top of the file.

Vagrant will spin up one "head node" and `N` worker nodes in a Spark standalone cluster.

Feel free to make other changes, e.g. RAM and CPU for each of the machines.

When you're ready, just run `vagrant up` in the directory the `Vagrantfile` is in. Wait a few minutes and your Spark cluster will be ready.

SSH in using `vagrant ssh hn0` or `vagrant ssh wn0`.

You'll also be able to see the Spark WebUI at `http://172.28.128.150:8080`.

Shut down the cluster with `vagrant halt` and delete it with `vagrant destroy`. You can always run `vagrant up` to turn on or build a brand new cluster.

# Testing #

To run my `PySpark-bigdata-treeset`(https://github.com/wwken/Misc_programs/blob/master/BigDataProblems/Spark-process-nyc-tree-set-statistics/processTree.py) on the cluster, run the following commands:

    vagrant ssh hn0
    spark-submit --queue default Spark-process-nyc-tree-set-statistics/processTree.py

# License #

See the LICENSE.txt file.
