
using bfv.spring4oe.aop.IAopRegistry.
using bfv.spring4oe.beans.factory.IBeanRegistry.

block-level on error undo, throw.


class bfv.spring4oe.beans.factory.AbstractBeanDefinitionReader abstract:
  
  define protected property Registry as IBeanRegistry no-undo get. set.
  define protected property AopRegistry as IAopRegistry no-undo get. set.
  
  constructor public AbstractBeanDefinitionReader(registryIn as IBeanRegistry, aopregistryIn as IAopRegistry):
    Registry    = registryIn.
    AopRegistry = aopregistryIn.
  end.
  
end class.