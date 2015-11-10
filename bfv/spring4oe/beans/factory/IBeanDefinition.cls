
using bfv.spring4oe.beans.factory.BeanPropertyDefintion.
using Progress.Lang.Object.

interface bfv.spring4oe.beans.factory.IBeanDefinition:
  
  define public property ClassName as character no-undo get. 
  define public property Singleton as logical no-undo get. 
  define public property ObjectRef as Object no-undo get. set.
  define public property InitMethod as character no-undo get. set.
  define public property FactoryMethod as character no-undo get. set.
  
  method public character GetPropertyNames().
  method public BeanPropertyDefintion GetProperty(propertyName as character).
  
end interface.