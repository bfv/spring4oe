 

using bfv.spring4oe.sample.ILogging from propath.

class spring4oe.misc.Logger: 
  
  define private stream logStream.
  
  
  constructor static Logger():
    output stream logStream to value(session:temp-directory + "beanfactory.log") unbuffered append.
  end constructor.
  
  
  method public static void Information(messageText as character):
    log-manager:write-message(messageText).
  end.

end class.