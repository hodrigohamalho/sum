Camel Project for Spring 
=========================================

To build this project use

```
    mvn install
```

To run the project you can execute the following Maven goal

```
    mvn camel:run
```

For more help see the Apache Camel documentation

    http://camel.apache.org/
    
Setup ActiveMQ
 
 ```
 	jms:create -t ActiveMQ -u tcp://localhost:61616 pepe
 ```

Install features:

```
	features:install camel-mail
	features:install camel-string-template
	features:install camel-jetty9
	features:install camel-script-groovy
	
```    

To deploy using Fuse:

``
	install -s mvn:com.mycompany/caso2/1.0.0
``

Testing the routes:

REST: http://localhost:8182/caso2/1/2

SOAP: http://localhost:8181/cxf/Sum?wsdl


