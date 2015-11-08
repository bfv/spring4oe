
using Progress.Lang.Object from propath.
using bfv.spring4oe.beans.factory.XmlBeanFactory from propath.
using bfv.spring4oe.beans.factory.IBeanFactory from propath.

define variable obj1 as Object no-undo.
define variable obj2 as Object no-undo.
define variable obj3 as Object no-undo.

define variable factory as IBeanFactory no-undo.

factory = new XmlBeanFactory("./bfv/spring4oe/sample/beans.xml").

obj1 = factory:GetBean("pablo").
obj2 = factory:GetBean("pablo").
obj3 = factory:GetBean("juan").

message obj1:GetClass():TypeName "~nobj1 = obj2:" obj1:Equals(obj2) "~nalias:" obj3:GetClass():TypeName view-as alert-box.
