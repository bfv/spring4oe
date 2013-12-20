 

class bfv.logging.Logger: 
  
  constructor static Logger():
    log-manager:logfile-name = "d:\devnew\spring\log\beanfactory.log".
  end constructor.

  method public static void Information(exceptionMessage as character):
    log-manager:write-message(exceptionMessage).
  end.
  
end class.