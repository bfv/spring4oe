
using bfv.spring4oe.beans.factory.IBeanDefinition.

block-level on error undo, throw.


class bfv.spring4oe.beans.factory.AbstractBeanDefinition implements IBeanDefinition abstract: 

  define public property ClassName     as character  no-undo get. private set.
  define public property Singleton     as logical    no-undo get. private set.
  define public property ObjectRef     as Progress.Lang.Object no-undo get. set. 
  define public property InitMethod    as character  no-undo get. set.
  define public property FactoryMethod as character  no-undo get. set.
  
  
  define protected temp-table ttproperty no-undo
    field pname     as character
    field pvalue    as character 
    field reference as character
    field valueprop as logical
    .
    
  
  constructor public AbstractBeanDefinition(classname as character, lsingleton as logical):
    this-object:ClassName = classname.
    this-object:Singleton = lsingleton.
  end.


  method public override character ToString():
    
    return 
      "classname=" + this-object:ClassName + " " +
      "singleton=" + string(this-object:Singleton, "true/false") + " " +
      "initmethod=" + this-object:InitMethod
      .
      
  end method.
  
  
  method public void AddPropertyValue(pname as character, pvalue as character):
    
    create ttproperty.
    assign 
      ttproperty.pname     = pname
      ttproperty.pvalue    = pvalue
      ttproperty.valueprop = true
      .
  end method.


  method public void AddPropertyReference(pname as character, pvalue as character):
    create ttproperty.
    assign 
      ttproperty.pname     = pname
      ttproperty.pvalue    = pvalue
      ttproperty.valueprop = false
      .
  end method.
  
  
  method public character GetPropertyNames():
    
    define variable pnames as character no-undo.
    
    
    for each ttproperty:
      pnames = pnames + "," + ttproperty.pname.
    end.  
    
    if (pnames > "") then
      pnames = substring(pnames, 2).
      
    return pnames.
         
  end method.
  
  
  method public bfv.spring4oe.beans.factory.BeanPropertyDefintion GetProperty(propertyname as character):
    
    find ttproperty where ttproperty.pname = propertyname no-error.
    if (avail ttproperty) then 
      return new bfv.spring4oe.beans.factory.BeanPropertyDefintion(ttproperty.pname, ttproperty.pvalue, ttproperty.valueprop).
    else
      return error.
      
  end method.
      
end class.