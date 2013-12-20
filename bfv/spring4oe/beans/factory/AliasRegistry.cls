using bfv.spring4oe.beans.factory.IAliasRegistry.
using bfv.logging.Logger.

class bfv.spring4oe.beans.factory.AliasRegistry implements IAliasRegistry:
  
  define protected temp-table ttalias
    field cname  as character
    field calias as character
    .
    
  method public void RegisterAlias(cname as character, calias as character):
    
    if (can-find(first ttalias where ttalias.calias = calias)) then
      undo, throw new bfv.spring4oe.beans.BeansException("Alias '" + calias + "' already defined").
      
    create ttalias.
    assign
      ttalias.calias = calias
      ttalias.cname  = cname
      .
    
    Logger:Information("registered: '" + calias + "' alias for '" + cname + "'").
      
  end method.

  
  method public logical IsAlias(calias as character).
    return can-find(first ttalias where ttalias.calias = calias).
  end method.


  method public character GetAliases(cname as character):
    
    def var caliases as character no-undo.
    
    for each ttalias where ttalias.cname = cname:
      caliases = caliases + "," + ttalias.calias.  
    end.
    
    if (caliases <> "") then
      caliases = substring(caliases, 2).
      
    return caliases.
    
  end method.
  
  
  method public character GetName(calias as character):
    find ttalias where ttalias.calias = calias no-error.
    return (if avail ttalias then ttalias.cname else calias).
  end method.
  
end class.