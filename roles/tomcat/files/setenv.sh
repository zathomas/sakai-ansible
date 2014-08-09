#export JAVA_OPTS="-server -Xmx1028m -XX:MaxPermSize=640m -Dorg.apache.jasper.compiler.Parser.STRICT_WHITESPACE=false -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false -Djava.awt.headless=true -Dcom.sun.management.jmxremote -Dsun.lang.ClassLoader.allowArraySyntax=true -Dedtell.rabbitmq.password=#edTe11"
export JAVA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n -server -Xmx1028m -XX:MaxPermSize=620m -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false -Djava.awt.headless=true -Dcom.sun.management.jmxremote -Dsun.lang.ClassLoader.allowArraySyntax=true -Dedtell.rabbitmq.password=#edTe11"
CLASSPATH=/usr/share/java/mysql-connector-java.jar

