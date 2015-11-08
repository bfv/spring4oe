spring4oe
=========

A few year ago I created spring4oe primarily the core stuff because I felt the need for a DI container. This project is based on the Spring 2.5 definitions.
Although the sources suggest there's some AOP stuff as well this is not functional.

disclaimer: this is Work In Progress. Please notice the MIT license attached.


Bean definitions
----------------

The Spring DI container is build around beans. There's nothing particular about a bean, other than it should a ABL class.
To make sure your XML is valid you may want to enter the appropriate namespaces:

...
<?xml version="1.0"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">
  
  <!-- the beans go here -->
         
</beans>
...