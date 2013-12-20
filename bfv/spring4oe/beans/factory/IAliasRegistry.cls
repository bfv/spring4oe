
interface bfv.spring4oe.beans.factory.IAliasRegistry:
  
  method public void      RegisterAlias(cname as character, calias as character).
  method public logical   IsAlias(calias as character).
  method public character GetAliases(cname as character).
  method public character GetName(calias as character).
    
end.