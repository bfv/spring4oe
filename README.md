spring4oe
=========

A few year ago I created spring4oe primarily the core stuff because I felt the need for a DI container. This project is based on the Spring 2.5 definitions.
Although the sources suggest there's some AOP stuff as well this is not functional.

disclaimer: this is Work In Progress. Please notice the MIT license attached.


Bean definitions
----------------

The Spring DI container is build around beans. There's nothing particular about a bean, other than it should a ABL class.
To make sure your XML is valid you may want to enter the appropriate namespaces.

### Bean definition template
```xml
<?xml version="1.0"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">
  
  <!-- the beans go here -->
         
</beans>
```
### Adding a bean
Spring is ibuild around the concept of mapping a logical to an actual class. The simplest form of defining a bean looks like:
```xml
<bean id="logger" class="bfv.spring4oe.misc.Logger" />
```
### Getting an  instance in ABL
```
using bfv.spring4oe.beans.factory.XmlBeanFactory from propath.
using bfv.spring4oe.beans.factory.IBeanFactory from propath.
using bfv.spring4oe.sample.ILogging from propath.

define variable factory as IBeanFactory no-undo.
define variable logger as ILogging no-undo.

factory = new XmlBeanFactory("./bfv/spring4oe/sample/beans.xml").

logger = cast(factory:GetBean("applogger"), "ILogging").
```
