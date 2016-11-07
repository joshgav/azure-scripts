SCRIPTS_DIR=`dirname $0`
MESOS_MASTER=~/mesos/build/bin/mesos-master.sh
MESOS_SLAVE=~/mesos/build/bin/mesos-slave.sh
MESOS_LOGDIR=/var/log/mesos
LOCAL_IPADDR=`$SCRIPTS_DIR/find-ip-address.sh`

nohup $MESOS_MASTER --cluster=joshgav-mesos --external_log_file=$MESOS_LOGDIR/master_console.log \
	--ip=$LOCAL_IPADDR --log_dir=$MESOS_LOGDIR --work_dir=$MESOS_LOGDIR/work \
	> $MESOS_LOGDIR/master_console.log 2>&1 &

nohup $MESOS_SLAVE --master=${LOCAL_IPADDR}:5050 --external_log_file=$MESOS_LOGDIR/slave_console.log \
	--ip=$LOCAL_IPADDR --log_dir=$MESOS_LOGDIR --work_dir=$MESOS_LOGDIR/work \
	> $MESOS_LOGDIR/slave_console.log 2>&1 &

