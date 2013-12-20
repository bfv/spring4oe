
interface bfv.spring4oe.beans.factory.IBeanDefinition:
  
  define public property ClassName     as character             no-undo get. 
  define public property Singleton     as logical               no-undo get. 
  define public property ObjectRef     as Progress.Lang.Object  no-undo get. set.
  define public property InitMethod    as character             no-undo get. set.
  define public property FactoryMethod as character             no-undo get. set.
  
  method public character GetPropertyNames().
  method public bfv.spring4oe.beans.factory.BeanPropertyDefintion GetProperty(propertyname as character).
  
end interface.