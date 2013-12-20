using bfv.spring4oe.beans.factory.AbstractBeanFactory.
using bfv.spring4oe.beans.factory.IBeanDefinitionReader.
using bfv.spring4oe.beans.factory.XmlBeanDefinitionReader.
using bfv.logging.Logger.

class bfv.spring4oe.beans.factory.XmlBeanFactory inherits AbstractBeanFactory:
  
    
  constructor public XmlBeanFactory(xmlfile as character):
    
    super().
    
    loadBeansDefinitions(xmlfile).
    BeansFactoryPostProcessing().
/*    InitBeans().*/
        
  end.
  
  
  method private void loadBeansDefinitions(xmlfile as character):
    
    def var filecontent as longchar                no-undo.
    def var reader      as IBeanDefinitionReader no-undo.
    
    xmlfile = search(xmlfile).
    
    if (xmlfile = ?) then
      undo, throw new bfv.spring4oe.beans.BeansException("Bean definition file not found").
    
    Logger:Information("Loading BeanDefs: " + xmlfile).
    
    copy-lob file xmlfile to filecontent.
    
    reader = new XmlBeanDefinitionReader(registry, aopregistry).
    reader:LoadDefinitions(filecontent).
    
  end method.
  
end class.