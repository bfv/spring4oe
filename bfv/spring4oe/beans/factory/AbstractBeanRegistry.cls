
using bfv.spring4oe.beans.factory.AliasRegistry.
using bfv.spring4oe.beans.factory.IBeanRegistry.
using bfv.spring4oe.beans.factory.IBeanDefinition.
using bfv.spring4oe.beans.BeansException.
using bfv.spring4oe.misc.Logger.
using bfv.spring4oe.beans.factory.BeanPropertyDefintion.

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
  
  method public void RegisterBeanDefinition(beanNameIn as character, beanDef as IBeanDefinItion):
    
    if (can-find(first ttregisteredbean where ttregisteredbean.beanname = beanNameIn)) then
      undo, throw new BeansException(substitute("Bean name '&1' already in use", beanNameIn)).
    
    create ttregisteredbean.
    assign
      ttregisteredbean.beanname = beanNameIn 
      ttregisteredbean.beandefinition = beanDef
      .
      
    Logger:Information("registered: '" + beanNameIn + "' --> '" + beandef:ClassName + "' " + (if (beandef:Singleton) then "singleton" else "prototype")).
    
  end method.
  
  /* fix the encapsulation breakage! */
  method public void GetRegisteredBeans(output table ttregisteredbean):
    
  end method.
  
  
  method public IBeanDefinition GetBeanDefinition(beanNameIn as character):
    
    define variable beanDef as IBeanDefinition no-undo.
    
    
    find ttregisteredbean where ttregisteredbean.beanname = beanNameIn no-error.
    if (not avail ttregisteredbean) then 
      undo, throw new bfv.spring4oe.beans.factory.NoSuchBeanDefinitionException().
      
    beanDef = cast(ttregisteredbean.beandefinition, "IBeanDefinition").
    
    return beanDef.
        
  end method.
  
  
  method public void CalcDependencies():
    
    define variable beanDef as IBeanDefinition no-undo.
    define variable propertyDef as BeanPropertyDefintion no-undo.
    define variable propertyNames as character no-undo.
    define variable i as integer no-undo.

    for each ttregisteredbean:

      beanDef = cast(ttregisteredbean.beandefinition, "IBeanDefinition").
      
      propertyNames = beanDef:GetPropertyNames().
      do i = 1 to num-entries(propertyNames):
        
        propertyDef = beanDef:GetProperty(entry(i, propertynames)).
        
        if (not propertyDef:IsValueProperty) then do:
          create ttdependency.
          assign 
            ttdependency.beanname   = ttregisteredbean.beanname
            ttdependency.references = GetName(propertyDef:Value)
            ttdependency.singleton  = beanDef:Singleton
            .
            
        end.
      
      end.  /* do i = ... */
      
    end.  /* for each ttregisteredbean */
    
    for each ttdependency:
      find ttregisteredbean where ttregisteredbean.beanname = ttdependency.references.
      ttregisteredbean.referenced = ttregisteredbean.referenced + 1.
    end.
    
    for each ttregisteredbean:
      Logger:Information(ttregisteredbean.beanname + " " + string(ttregisteredbean.referenced) + " referenced").
    end.
    
  end method.
  
end class.