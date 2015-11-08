
using bfv.spring4oe.aop.IAopRegistry.
using bfv.spring4oe.beans.factory.IBeanRegistry.

block-level on error undo, throw.


class bfv.spring4oe.beans.factory.AbstractBeanDefinitionReader abstract:
  
  define protected variable registry    as IBeanRegistry no-undo.
  define protected variable aopregistry as IAopRegistry  no-undo.
  
  constructor public AbstractBeanDefinitionReader(registry as IBeanRegistry, aopregistry as IAopRegistry):
    this-object:registry    = registry.
    this-object:aopregistry = aopregistry.
  end.
  
end class.