spring4oe
=========

A few year ago I created spring4oe primarily because I felt the need for a DI container. This project is based on the Spring 2.5 definitions.
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
       xsi:schemaLocation="http://www.springframework.org/schema/beans 
       http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">
  
  <!-- the beans go here -->
         
</beans>
```
### Adding a bean
Spring is ibuild around the concept of mapping a logical to an actual class. The simplest form of defining a bean looks like:
```xml
<bean id="applogger" class="bfv.spring4oe.sample.AppLogger" />
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
### Setting a property
It is also possible to set a (public) property of a class. Our AppLogger class for example has a LogFilename property which allows us to set the filename to which is logged. Setting this property look like this:
```xml
<bean id="applogger" class="bfv.spring4oe.sample.AppLogger">
  <property name="LogFilename" value="./../../log/app.log"/>
</bean>
```
Not only is it possible to set a value, it is also possible to set a reference, which is a reference to a class. For example if you want to specify that your session manager needs to use the applogger defined ealier this is the way to go:
```xml
<bean id="sessman" class="bfv.spring4oe.sample.SessionManager">
  <property name="Logger" ref="applogger" />
</bean>
```
The property *Logger* is set to what applogger point to, which is the *bfv.spring4oe.sample.AppLogger* class.
### Setting an initialization method
Just setting a property is most of the time not enough to accomplish the desired behavior. Setting the property *and* call a method which can act upon this property does the trick. In Spring this method can be specfied via the *init-method*
```xml
<bean id="applogger" class="bfv.spring4oe.sample.AppLogger" init-method="InitLogger">
  <property name="LogFilename" value="./../../log/app.log"/>
</bean>
```
First the object is constructed, then the properties are set and finally the *init-method* is called.
The 4GL part could look like:
<pre>
class bfv.spring4oe.sample.AppLogger implements ILogging: 
  
  define public property LogFilename as character no-undo get. set. 
  define private stream logStream.
  
  method public void Log(messageText as character):       
    put stream logStream unformatted iso-date(now) " " messageText skip.      
  end method.
 
  method public void InitLogger():
    output stream logStream to value(logFilename) unbuffered.   
  end method.
  
end class.
</pre>
### Singletons
By default a bean is a singleton. The container returns the same reference every time. When it is necessary to return a new instance on every call to GetBean you can set the *scope* attribute of the bean to *prototype*.
```xml
<bean id="pablo" class="Progress.Lang.Object" scope="prototype" />
```
*PS. why pablo? It stands for Plain ABL Object, which is an simpel object which doesn't need some complicated instantiation. It's the ABL version of a POJO.*

### Factory methods
Sometimes it necessary to control the lifespan of an object by logic in the class itself. Spring4oe gives this possibility via a so-called factory method. This factory method is a static method and can be set via the *factory-method* on the bean.
```xml
<bean id="factmeth" class="bfv.spring4oe.sample.FactoryMethodSample" 
  factory-method="GiveMeAnInstance" />
```
with the accompanying 4GL
<pre>
class bfv.spring4oe.sample.FactoryMethodSample: 
  
  method public static FactoryMethodSample GiveMeAnInstance():
    return new FactoryMethodSample().
  end method. 
  
end class.
</pre>

### Alias
Whenever it is handy to have two logical names for what is in essence the same, one can use an alias:
```xml
<bean id="pablo" class="Progress.Lang.Object" scope="prototype" />
<alias alias="juan" name="pablo" />
```
