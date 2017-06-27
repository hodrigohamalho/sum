#echo "Starting cluster...."
#sh /Users/rramalho/Documents/oc-cluster-up

echo "Install the FIS 2.0 image stream"
echo

oc login -u system:admin
echo "Install ImageStream"
oc create -f jboss-image-streams.json -n openshift 
oc create -f fis-image-streams.json -n openshift

oc login -u developer
oc new-project fis --display-name="FIS demo"

echo "Start up Broker"
oc import-image amq62-openshift --from=registry.access.redhat.com/jboss-amq-6/amq62-openshift --confirm
oc create -f amq62-openshift.json
oc new-app --template=amq62-basic --param=MQ_USERNAME=redhat --param=MQ_PASSWORD=redhat --param=IMAGE_STREAM_NAMESPACE=fis

echo "Removing unecessary services"
oc delete svc broker-amq-amqp broker-amq-mqtt broker-amq-stomp
