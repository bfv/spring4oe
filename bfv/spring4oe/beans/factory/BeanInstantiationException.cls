using Progress.Lang.*.
using bfv.spring4oe.beans.BeansException. 


class bfv.spring4oe.beans.factory.BeanInstantiationException inherits BeansException: 
  
  constructor public BeanInstantiationException():
    super("BeanInstantiationException").
  end.
  
  constructor public BeanInstantiationException(exceptionMessage as character):
    super(exceptionMessage).
  end.
  
  
end class.