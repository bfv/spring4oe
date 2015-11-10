
using bfv.spring4oe.beans.factory.IAliasRegistry.
using bfv.spring4oe.misc.Logger.

block-level on error undo, throw.


class bfv.spring4oe.beans.factory.AliasRegistry implements IAliasRegistry:
  
  define protected temp-table ttalias
    field cname  as character
    field calias as character
    .
    
  method public void RegisterAlias(forName as character, aliasName as character):
    
    if (can-find(first ttalias where ttalias.calias = aliasName)) then
      undo, throw new bfv.spring4oe.beans.BeansException("Alias '" + aliasName + "' already defined").
      
    create ttalias.
    assign
      ttalias.calias = aliasName
      ttalias.cname  = forName
      .
    
    Logger:Information("registered: '" + aliasName + "' alias for '" + forName + "'").
      
  end method.

  
  method public logical IsAlias(aliasName as character).
    return can-find(first ttalias where ttalias.calias = aliasName).
  end method.


  method public character GetAliases(forName as character):
    
    define variable caliases as character no-undo.
    
    for each ttalias where ttalias.cname = forName:
      caliases = caliases + "," + ttalias.calias.  
    end.
    
    if (caliases <> "") then
      caliases = substring(caliases, 2).
      
    return caliases.
    
  end method.
  
  
  method public character GetName(aliasName as character):
    find ttalias where ttalias.calias = aliasName no-error.
    return (if available(ttalias) then ttalias.cname else aliasName).
  end method.
  
end class.