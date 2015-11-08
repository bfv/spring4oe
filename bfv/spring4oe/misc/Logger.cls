 

using bfv.spring4oe.sample.ILogging from propath.

class bfv.spring4oe.misc.Logger: 
  
  define private stream logStream.
  
  
  constructor static Logger():
    output stream logStream to value(session:temp-directory + "beanfactory.log") unbuffered append.
  end constructor.
  
  
  method public static void Information(messageText as character):
    put stream logStream unformatted iso-date(now) " " messageText skip.
  end.

end class.