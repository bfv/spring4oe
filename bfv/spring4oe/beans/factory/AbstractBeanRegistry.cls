
using bfv.spring4oe.beans.factory.AliasRegistry.
using bfv.spring4oe.beans.factory.IBeanRegistry.
using bfv.spring4oe.beans.factory.IBeanDefinition.
using bfv.spring4oe.beans.BeansException.
using bfv.spring4oe.misc.Logger.

block-level on error undo, throw.


class bfv.spring4oe.beans.factory.AbstractBeanRegistry 
        inherits   AliasRegistry
        implements IBeanRegistry
        abstract:
  
  {bfv/spring4oe/beans/factory/ttregisteredbean.i &accessor=protected}
  {bfv/spring4oe/beans/factory/ttdependency.i &accessor=private}
  
  define temp-table ttprocessedbean
    field beanname as character
    .
    
  /*
  constructor public AbstractBeanRegistry():
    
  end constructor.
  */
  
  method public void RegisterBeanDefinition(cname as character, beandef as IBeanDefinItion):
    
    if (can-find(first ttregisteredbean where ttregisteredbean.beanname = cname)) then
      undo, throw new BeansException("Bean name ' " + cname + "' already in use").
    
    create ttregisteredbean.
    assign
      ttregisteredbean.beanname       = cname 
      ttregisteredbean.beandefinition = beandef 
      .
      
    Logger:Information("registered: '" + cname + "' --> '" + beandef:ClassName + "' " + (if (beandef:Singleton) then "singleton" else "prototype")).
    
  end method.
  
  /* fix the encapsulation breakage! */
  method public void GetRegisteredBeans(output table ttregisteredbean):
    
  end method.
  
  
  method public IBeanDefinition GetBeanDefinition(cname as character):
    
    def var beandef as IBeanDefinition no-undo.
    
    
    find ttregisteredbean where ttregisteredbean.beanname = cname no-error.
    if (not avail ttregisteredbean) then 
      undo, throw new bfv.spring4oe.beans.factory.NoSuchBeanDefinitionException().
      
    beandef = cast(ttregisteredbean.beandefinition, "IBeanDefinition").
    
    return beandef.
        
  end method.
  
  
  method public void CalcDependencies():
    
    def var beandef       as IBeanDefinition no-undo.
    def var propdef       as bfv.spring4oe.beans.factory.BeanPropertyDefintion no-undo.
    def var propertynames as character no-undo.
    def var i             as integer   no-undo.

    for each ttregisteredbean:

      beandef = cast(ttregisteredbean.beandefinition, "IBeanDefinition").
      
      propertynames = beandef:GetPropertyNames().
      do i = 1 to num-entries(propertynames):
        
        propdef = beandef:GetProperty(entry(i, propertynames)).
        
        if (not propdef:IsValueProperty) then do:
          create ttdependency.
          assign 
            ttdependency.beanname   = ttregisteredbean.beanname
            ttdependency.references = GetName(propdef:Value)
            ttdependency.singleton  = beandef:Singleton
            .
            
        end.
      
      end.
      
    end.
    
    for each ttdependency:
      
      find ttregisteredbean where ttregisteredbean.beanname = ttdependency.references.
      assign 
        ttregisteredbean.referenced = ttregisteredbean.referenced + 1.
        
    end.
    
    temp-table ttdependency:write-xml("file", "c:/tmp/ttdependency.xml", true).
    
    for each ttregisteredbean:
      Logger:Information(ttregisteredbean.beanname + " " + string(ttregisteredbean.referenced) + " referenced").
    end.
     
  end method.
  
end class.