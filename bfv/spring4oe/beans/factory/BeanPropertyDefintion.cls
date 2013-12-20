class bfv.spring4oe.beans.factory.BeanPropertyDefintion:
  
  define public property Name  as character          no-undo get. private set.
  define public property Value as character          no-undo get. private set.
  define public property IsValueProperty as logical  no-undo get. private set.
   
  constructor public BeanPropertyDefintion(propertyName as character, propertyValue as character, valueProperty as logical):
    this-object:Name  = propertyName.
    this-object:Value = propertyValue.
    IsValueProperty   = valueProperty.      
  end.
  
end class.