using bfv.spring4oe.aop.*.
using bfv.spring4oe.misc.Logger.

class bfv.spring4oe.aop.AopDefinitionReader implements IAopDefinitionReader:
  
  define private variable registry as IAopRegistry.
  
  define private variable xchild as handle no-undo.
  define private variable xattr  as handle no-undo.

  
  constructor public AopDefinitionReader(reg as IAopRegistry):
    
    registry = reg.
    
    create x-noderef xchild.
    create x-noderef xattr.
    
  end.
 
  destructor public AopDefinitionReader():
    delete object xattr  no-error.
    delete object xchild no-error.
  end.

  method public void ProcessAop(xaop as handle):
    
    define variable i           as integer   no-undo.
    define variable numchildren as integer   no-undo.
    define variable ctype       as character no-undo.
    
    numchildren = xaop:num-children.
    do i = 1 to numchildren:
      
      xaop:get-child(xchild, i).
      if (xchild:subtype = "element") then do:
        
        ctype = xchild:name.
        
        case ctype:
          
          when "aop:aspect" then 
            processAspect(xchild).
              
          when "aop:pointcut" then
            processPointcut(xchild).
            
        end case.
 
      end.
     
        
    end.
    
    delete object xchild no-error.
    
  end method.

  
  method public void processAspect(xaspect as handle):
    
  end method.
  
  
  method public void processPointcut(xpointcut as handle):
    
    define variable i      as integer   no-undo.
    define variable id     as character no-undo.
    define variable expr   as character no-undo.
    define variable cname  as character no-undo.
    define variable cvalue as character no-undo.
    define variable iattr  as integer   no-undo.
    
    iattr = num-entries(xpointcut:attribute-names).
    do i = 1 to iattr:
      
      cname  = entry(i, xpointcut:attribute-names).
      cvalue = xpointcut:get-attribute(cname).
      
      case cname:
        
        when "id" then 
          id = cvalue.
          
        when "expression" then 
          expr = cvalue.
          
      end case.
      
    end.
    
    registry:RegisterPointcut(id, expr).
    
  end method.
  
end class.