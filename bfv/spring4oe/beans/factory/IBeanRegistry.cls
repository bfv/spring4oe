using bfv.spring4oe.beans.factory.IBeanDefinItion.
using bfv.spring4oe.beans.factory.IAliasRegistry.

interface bfv.spring4oe.beans.factory.IBeanRegistry inherits IAliasRegistry:
  
  {bfv/spring4oe/beans/factory/ttregisteredbean.i}
  
  method public void RegisterBeanDefinition(beanNameIn as character, beanDef as IBeanDefinItion). 
  method public IBeanDefinition GetBeanDefinition(cname as character).
  method public void GetRegisteredBeans(output table ttregisteredbean).
  method public void CalcDependencies().
  
end interface.