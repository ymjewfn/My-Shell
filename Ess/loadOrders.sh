export CLASSPATH=/tmp/mqtools61.jar:$CLASSPATH:/usr/mqm/java/lib/com.ibm.mq.jmqi.jar:/usr/mqm/java/lib/com.ibm.mq.jar:/usr/mqm/java/lib/CL3Export.jar:/usr/mqm/java/lib/CL3Nonexport.jar:/usr/mqm/java/lib/com.ibm.mq.commonservices.jar:/usr/mqm/java/lib/com.ibm.mq.defaultconfig.jar:/usr/mqm/java/lib/com.ibm.mq.headers.jar:/usr/mqm/java/lib/com.ibm.mq.jar:/usr/mqm/java/lib/com.ibm.mq.jms.Nojndi.jar:/usr/mqm/java/lib/com.ibm.mq.pcf.jar:/usr/mqm/java/lib/com.ibm.mq.postcard.jar:/usr/mqm/java/lib/com.ibm.mq.soap.jar:/usr/mqm/java/lib/com.ibm.mq.tools.ras.jar:/usr/mqm/java/lib/com.ibm.mqjms.jar:/usr/mqm/java/lib/connector.jar:/usr/mqm/java/lib/dhbcore.jar:/usr/mqm/java/lib/fscontext.jar:/usr/mqm/java/lib/jms.jar:/usr/mqm/java/lib/jndi.jar:/usr/mqm/java/lib/jta.jar:/usr/mqm/java/lib/ldap.jar:/usr/mqm/java/lib/providerutil.jar:/usr/mqm/java/lib/rmm.jar

for file in replayOrders/*
do
  echo Trying to run load of ${file}
  # java net.dsps.tools.LoadFromFile CommerceMQ.outbound WCQMgrProd localhost 1414 SYSTEM.DEF.CLNTCONN ${file}
  java net.dsps.tools.LoadFileAsMessage CommerceMQ.outbound WCQMgrProd localhost 1414 SYSTEM.DEF.CLNTCONN ${file}
  echo Load ended with status of $?
done
