#!/bin/bash

#SBATCH --job-name=spark_multinode
#SBATCH --nodes=2					#Nodes
#SBATCH --ntasks-per-node=2         #will request 2 cores across multiple nodes
#SBATCH --time=01:00:00             #time to run the job
#SBATCH -p short                    #short partition with a 24hour time limit
#SBATCH --constraint=ib             #run only on the new nodes with IB network
#SBATCH --mem=0                     #get all available memory on the node

module load spark/2.3.2-hadoop2.7

# This syntax tells spark to use all cpu cores on the node.
export MASTER="local[*]"

script=binary_classification_metrics_example.py

        # check what time it is before the job starts
        STARTT=`date +%s`

        spark-submit --master $MASTER --total-executor-cores $SLURM_NTASKS $script

        # check what time it is when the command finishes
        ENDT=`date +%s`
        ELAPSED=`echo 0 | awk -v e=$ENDT -v s=$STARTT '{print e-s}'`
                     echo "Number of cores: $SLURM_NTASKS , run-time: $ELAPSED seconds" >> performance.log
