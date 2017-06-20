== Sum Project

This is a simple project to demonstrate a couple of EIPs applied using Red Hat Jboss Fuse.

Basically this project receive two values via webservice SOAP and REST and sum it saving the result in a file system.

=== Use case
. Receive two integer parameters via REST and SOAP 
. Imediatly return a "OK" String to a valid two integers values 
. Imediatly return a "NOK" String to a non valid two integers values 
. Send in background the two values to sum 
. Send the result to a Active-MQ queue
. Retrieve the result from the queue and save in a file 
. In case of the queue is unavailable, handle the error and send an email to a previously configured account 
. Mail configuration and queue names could be changed in a file outside the project

=== Build 

To build this project use:
	
	mvn clean install

=== Requirements

* Red Hat Jboss Fuse 6.3
* SMTP server. 
I used the fake-smtp.jar to mock a mail server. To run:

	java -jar resources/fake-smtp.jar 

And specify port 2525.

=== Running the application

==== Local

	mvn spring-boot:run

==== Openshift

	oc cluster up
	sh support/setup.sh
	mvn fabric8:deploy
	
Access the project in: https://127.0.0.1:8443/console/project/fis

	User: developer
	Pass: developer

	
To override properties, is necessary to create file called sum.cfg in $FUSE_HOME/etc directory. 

An example of an file with supported properties above:

	queueName=soma
	smtp.host=localhost
	smtp.port=2525
	smtp.to=afranco@redhat.com
	smtp.from=hodrigohamalho@gmail.com

To test the unavailable message queue, a easy way is stopping openwire connector from the ActiveMQ tab panel in the Fuse web console (Hawtio)

=== Test the route 

REST: http://localhost:8183/sum/1/2

SOAP: http://localhost:8181/services/Sum?wsdl

You should see a OK as result.

And inspect the file inside your ./sumDir to show the results of the sum.