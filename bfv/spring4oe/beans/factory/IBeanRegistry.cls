using bfv.spring4oe.beans.factory.IBeanDefinItion.

interface bfv.spring4oe.beans.factory.IBeanRegistry:
  
  {bfv/spring4oe/beans/factory/ttregisteredbean.i}
  
  method public void RegisterBeanDefinition(cname as character, beandef as IBeanDefinItion). 
  method public IBeanDefinition GetBeanDefinition(cname as character).
  method public void GetRegisteredBeans(output table ttregisteredbean).
  
  
  /* inherited from IAliasRegistry: */
  method public void      RegisterAlias(cname as character, calias as character).
  method public logical   IsAlias(calias as character).
  method public character GetAliases(cname as character).
  method public character GetName(calias as character).
  method public void      CalcDependencies().
  
end interface.