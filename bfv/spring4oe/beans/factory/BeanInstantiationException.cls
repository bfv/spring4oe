
using bfv.spring4oe.beans.BeansException. 

block-level on error undo, throw.


class bfv.spring4oe.beans.factory.BeanInstantiationException inherits BeansException: 
  
  constructor public BeanInstantiationException():
    super("BeanInstantiationException").
  end.
  
  constructor public BeanInstantiationException(exceptionMessage as character):
    super(exceptionMessage).
  end.
    
end class.