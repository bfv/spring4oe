using bfv.spring4oe.beans.factory.XmlBeanFactory from propath.
using bfv.spring4oe.beans.factory.IBeanFactory from propath.
using bfv.spring4oe.sample.ILogging from propath.
using bfv.spring4oe.sample.SessionManager from propath.

block-level on error undo, throw.


define variable factory as IBeanFactory no-undo.
define variable sessman as SessionManager no-undo.


factory = new XmlBeanFactory("./bfv/spring4oe/sample/beans.xml").

sessman = cast(factory:GetBean("sessman"), "SessionManager").
