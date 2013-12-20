using bfv.spring4oe.aop.*.


interface bfv.spring4oe.aop.IAopRegistry:
  
  define public property definitionreader as IAopDefinitionReader no-undo get. 
  
  method public void RegisterPointcut(id as character, expression as character).
  
end interface.