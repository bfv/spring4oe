
using bfv.spring4oe.beans.factory.BeanPropertyDefintion.
using bfv.spring4oe.aop.IAopRegistry.
using bfv.spring4oe.aop.AopRegistry.
using bfv.spring4oe.beans.factory.BeanRegistry.
using bfv.spring4oe.beans.factory.IBeanDefinition.
using bfv.spring4oe.beans.factory.IBeanFactory.
using bfv.spring4oe.beans.factory.IBeanRegistry.
using bfv.spring4oe.beans.factory.IBeanDefinitionReader.
using bfv.spring4oe.beans.factory.BeanInstantiationException.
using bfv.spring4oe.misc.Logger.
using Progress.Lang.Object.


class bfv.spring4oe.beans.factory.AbstractBeanFactory implements IBeanFactory abstract:
  
  {bfv/spring4oe/beans/factory/ttregisteredbean.i &accessor=protected}
  
  define protected property Registry as IBeanRegistry no-undo get. set.
  define protected property Reader as IBeanDefinitionReader no-undo get. set.
  define protected property AopRegistry as IAopRegistry no-undo get. set. 

  define private temp-table ttDependency no-undo
    field beanname     as character
    field references   as character
    field referencedby as character
    index beanname as primary unique beanname
    .
  
  constructor public AbstractBeanFactory():
    Registry = new BeanRegistry().
    AopRegistry = new AopRegistry().
  end.
  
  
  method public Progress.Lang.Object GetBean(beanName as character):
    
    define variable beandef as IBeanDefinition no-undo.
    
    Logger:Information("Getting bean: " + beanName).
    
    /* check if the name is an alias */
    if (Registry:IsAlias(beanName)) then
     beanName = Registry:GetName(beanName).
    
    beandef = Registry:GetBeanDefinition(beanName).
    
    if (beandef:Singleton and valid-object(beandef:ObjectRef)) then
      return beandef:ObjectRef.  
    
    return instantiateBean(beandef).
    
  end method.
  
  
  method protected void InitBeans():
    
    define variable beanDef as IBeanDefinition no-undo.
    
    
    /* breaks encapsulation */
    registry:GetRegisteredBeans(output table ttregisteredbean).
    
    
    /* check for dependencies, referenced beans first! */
    for each ttregisteredbean:
      
      beanDef = cast(ttregisteredbean.beandefinition, "IBeanDefinition").
      Logger:Information("Processing  bean: " + ttregisteredbean.beanname + "-->" + beanDef:ClassName).
     
      if (beanDef:Singleton) then do:
        
        do on error undo, throw:
          Logger:Information("  Instantiating singleton: " + ttregisteredbean.beanname).
          instantiateBean(beanDef).
        end.
        
      end.
      
    end.
    
  end method.
  
  
  method private Progress.Lang.Object instantiateBean(beanDef as IBeanDefinition):
    
    define variable propertyDef as bfv.spring4oe.beans.factory.BeanPropertyDefintion no-undo.
    define variable className as character no-undo.
    define variable propertyNames as character no-undo.
    define variable i as integer no-undo.
    
    
    /* instantiate */
    do on error undo, throw:
      
      className = beanDef:ClassName.
      
      /* Bean instance */
      if (beanDef:FactoryMethod = "") then 
        beanDef:ObjectRef = dynamic-new (className) ().
      else 
        beanDef:ObjectRef = dynamic-invoke(className, beandef:FactoryMethod).
      
      /* Set the Bean properties */
      propertynames = beanDef:GetPropertyNames().
      do i = 1 to num-entries(propertyNames):
        
        propertyDef = beanDef:GetProperty(entry(i, propertyNames)).
        
        if (propertyDef:IsValueProperty) then
          dynamic-property(beanDef:ObjectRef, propertyDef:Name) = propertyDef:Value.  
        else
          dynamic-property(beanDef:ObjectRef, propertyDef:Name) = GetBean(propertyDef:Value).     
        
      end.
      
      /* init-method */
      if (beanDef:InitMethod > "") then do:
        Logger:Information("  Running init-method: " + beanDef:InitMethod).
        dynamic-invoke(beanDef:ObjectRef, beanDef:InitMethod).
      end.

      catch e as Progress.Lang.Error :
        undo, throw new BeanInstantiationException(substitute("Instantiating class '&1' failed: &2", className, e:GetMessage(1))).  
      end catch.
      
    end.   
        
    return beanDef:ObjectRef.
    
  end method.
  
  /** BEAN LIFECYCLE: 
    * 
    * - instantiate bean  ........................... OK                       
    * - populate properties ......................... OK
    * - BeanNameAware's SetBeanName (?) .............
    * - BeanFactoryAware's SetFactoryName ...........
    * - Preinitialization BeanPostProcessor .........
    * - InitializingBean's AfterPropertiesSet .......
    * - Call Custom init-method ..................... OK
    * - Postinitialization BeanPostProcessor ........
    * 
    * READY TO USE
    * 
    * Container shutdown:
    * 
    * - DisposableBean's destroy() ..................
    * - Call custom destroy-method ..................
    *
    **/
    
  method protected void BeansFactoryPostProcessing():
    Registry:CalcDependencies().
  end method. 
    
end class.