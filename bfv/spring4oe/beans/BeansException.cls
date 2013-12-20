
using Progress.Lang.AppError. 
using bfv.logging.Logger.


class bfv.spring4oe.beans.BeansException inherits AppError: 

  constructor public BeansException(exceptionMessage as character):
    
    super(exceptionMessage).
    
    Logger:Information(exceptionMessage).
    
    def var i as integer no-undo.
          
    do i = 1 to error-status:num-messages:
      Logger:Information(error-status:get-message(i)).
    end.
    
  end.

end class.