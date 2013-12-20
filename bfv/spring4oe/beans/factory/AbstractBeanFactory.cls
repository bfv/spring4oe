
using bfv.spring4oe.beans.factory.BeanPropertyDefintion.
using bfv.spring4oe.aop.IAopRegistry.
using bfv.spring4oe.aop.AopRegistry.
using bfv.spring4oe.beans.factory.BeanRegistry.
using bfv.spring4oe.beans.factory.IBeanDefinition.
using bfv.spring4oe.beans.factory.IBeanFactory.
using bfv.spring4oe.beans.factory.IBeanRegistry.
using bfv.spring4oe.beans.factory.IBeanDefinitionReader.
using bfv.spring4oe.beans.factory.BeanInstantiationException.
using bfv.logging.Logger.

class bfv.spring4oe.beans.factory.AbstractBeanFactory implements IBeanFactory abstract:
  
  {bfv/spring4oe/beans/factory/ttregisteredbean.i &accessor=protected}
  
  define protected variable registry    as IBeanRegistry         no-undo.
  define protected variable reader      as IBeanDefinitionReader no-undo.
  define protected variable aopregistry as IAopRegistry          no-undo. 

  define private temp-table ttDependency no-undo
    field beanname     as character
    field references   as character
    field referencedby as character
    index beanname as primary unique beanname
    .
  
  constructor public AbstractBeanFactory():
    registry    = new BeanRegistry().
    aopregistry = new AopRegistry().
  end.
  
  
  method public Progress.Lang.Object GetBean(cname as character):
    
    def var beandef as IBeanDefinition no-undo.
    
    Logger:Information("Getting bean: " + cname).
    
    /* check if the name is an alias */
    if (registry:IsAlias(cname)) then
     cname = registry:GetName(cname).
    
    beandef = registry:GetBeanDefinition(cname).
    
    if (beandef:Singleton and valid-object(beandef:ObjectRef)) then do:
      return beandef:ObjectRef.  
    end.  
    
    /*
    if (beandef:Singleton) then
      Logger:Information("No valid object reference for bean '" + cname + "'"). 
    */
    return instantiateBean(beandef).
    
  end method.
  
  
  method protected void InitBeans():
    
    def var beandef as IBeanDefinition no-undo.
    def var cname   as character       no-undo.
    
    
    /* breaks encapsulation */
    registry:GetRegisteredBeans(output table ttregisteredbean).
    
    
    /* check for dependencies, referenced beans first! */
    for each ttregisteredbean:
      
      beandef = cast(ttregisteredbean.beandefinition, "IBeanDefinition").
      
      Logger:Information("Processing  bean: " + ttregisteredbean.beanname + "-->" + beandef:ClassName).
      
      cname = beandef:ClassName. 
     
      if (beandef:Singleton) then do:
        
        do on error undo, leave:
                    
          Logger:Information("  Instantiating singleton: " + ttregisteredbean.beanname).
          instantiateBean(beandef).
          /*
          catch e as Progress.Lang.Error:
            
          end catch.
          */
        end.
        
      end.
      
    end.
    
  end method.
  
  
  method private Progress.Lang.Object instantiateBean(beandef as IBeanDefinition):
    
    def var propdef       as bfv.spring4oe.beans.factory.BeanPropertyDefintion no-undo.
    def var classname     as character no-undo.
    def var propertynames as character no-undo.
    def var i             as integer   no-undo.
    
    
    /* instantiate */
    do on error undo, throw:
      
      classname = beandef:ClassName.
      
      /* Bean instance */
      if (beandef:FactoryMethod = "") then 
        beandef:ObjectRef = dynamic-new classname ().
      else 
        beandef:ObjectRef = dynamic-invoke(classname, beandef:FactoryMethod).
      
      /* Set the Bean properties */
      propertynames = beandef:GetPropertyNames().
      do i = 1 to num-entries(propertynames):
        
        propdef = beandef:GetProperty(entry(i, propertynames)).
        
        if (propdef:IsValueProperty) then
          dynamic-property(beandef:ObjectRef, propdef:Name) = propdef:Value.  
        else
          dynamic-property(beandef:ObjectRef, propdef:Name) = GetBean(propdef:Value).     
        
      end.
      
      /* init-method */
      if (beandef:InitMethod > "") then do:
        Logger:Information("  Running init-method: " + beandef:InitMethod).
        dynamic-invoke(beandef:ObjectRef, beandef:InitMethod).
      end.

      catch e as Progress.Lang.Error :
        return error new BeanInstantiationException("Instantiating class '" + classname + "' failed" + e:GetMessage(1)).  
      end catch.
      
    end.   
        
    return beandef:ObjectRef.
    
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
    registry:CalcDependencies().
  end method. 
    
end class.