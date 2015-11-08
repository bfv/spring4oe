 
using Progress.Lang.*.
using bfv.spring4oe.beans.factory.*.

block-level on error undo, throw.


class bfv.spring4oe.beans.factory.BeanDefinition inherits bfv.spring4oe.beans.factory.AbstractBeanDefinition: 

  
  constructor public BeanDefinition(classname as character, lsingleton as logical):
    super(classname, lsingleton).  
  end.
  
end class.