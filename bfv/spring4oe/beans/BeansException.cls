
using Progress.Lang.AppError. 
using bfv.spring4oe.misc.Logger.

block-level on error undo, throw.


class bfv.spring4oe.beans.BeansException inherits AppError: 

  constructor public BeansException(exceptionMessage as character):
    
    define variable i as integer no-undo.
          
    super(exceptionMessage, -1).
    
    Logger:Information(exceptionMessage).
    
    do i = 1 to error-status:num-messages:
      Logger:Information(error-status:get-message(i)).
    end.
    
  end.

end class.