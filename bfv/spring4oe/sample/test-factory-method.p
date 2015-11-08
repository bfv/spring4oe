
using bfv.spring4oe.beans.factory.XmlBeanFactory from propath.
using bfv.spring4oe.beans.factory.IBeanFactory from propath.
using bfv.spring4oe.sample.ILogging from propath.
using bfv.spring4oe.sample.SessionManager from propath.
using Progress.Lang.Object from propath.

block-level on error undo, throw.

define variable obj as Object no-undo.

define variable factory as IBeanFactory no-undo.

factory = new XmlBeanFactory("./bfv/spring4oe/sample/beans.xml").

obj = factory:GetBean("factmeth").

message obj:GetClass():TypeName view-as alert-box.