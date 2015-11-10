 
using bfv.spring4oe.sample.ILogging from propath.
using Progress.Lang.AppError from propath.


block-level on error undo, throw.

class bfv.spring4oe.sample.AppLogger implements ILogging: 
  
  define private variable loggerInitialized as logical no-undo.  

  define public property LogFilename as character no-undo 
    get. 
    set(valueIn as character):
      if (loggerInitialized) then 
        undo, throw new AppError("Cannot set AppLogger filename once it is initialized", -1).
      LogFilename = valueIn.
    end.
  
  define private stream logStream.
  
  
	destructor AppLogger():
	  output stream logStream close.
	  catch err1 as Progress.Lang.Error :
    	/* do nothing */	
    end catch.
	end.

	method public void Log(messageText as character):			  
		put stream logStream unformatted iso-date(now) " " messageText skip.		  
	end method.
 
 
  method public void InitLogger():
    output stream logStream to value(logFilename) unbuffered.   /* the output is needed directly, hence unbuffered */
  end method.
  
end class.