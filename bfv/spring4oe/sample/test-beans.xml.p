
using bfv.spring4oe.beans.factory.XmlBeanFactory from propath.
using bfv.spring4oe.beans.factory.IBeanFactory from propath.
using bfv.spring4oe.sample.ILogging from propath.

block-level on error undo, throw.


define variable factory as IBeanFactory no-undo.
define variable logger as ILogging no-undo.
define variable logger2 as ILogging no-undo.


factory = new XmlBeanFactory("./bfv/spring4oe/sample/beans.xml").

logger = cast(factory:GetBean("applogger"), "ILogging").
logger2 = cast(factory:GetBean("applogger"), "ILogging").

message logger:Equals(logger2).
  
logger:Log("hello world").

catch err1 as Progress.Lang.Error :
	message err1:GetMessage(1) error-status:get-message(1).	
end catch.