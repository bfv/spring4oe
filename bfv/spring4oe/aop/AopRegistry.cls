using bfv.spring4oe.aop.*.
using bfv.logging.Logger.

class bfv.spring4oe.aop.AopRegistry implements IAopRegistry:
  
  {bfv/spring4oe/aop/ttpointcut.i}
  
  define public property definitionreader as IAopDefinitionReader no-undo get. private set.
  
  constructor public AopRegistry():
    definitionreader = new AopDefinitionReader(this-object).
  end.
  
  method public void RegisterPointcut(id-in as character, expression-in as character):
    
    create ttpointcut.
    assign
      ttpointcut.id         = id-in
      ttpointcut.expression = expression-in
      .
    
    Logger:Information("Pointcut id='" + id-in + "' registered").
    
  end.
  
  method public character SatisfiesPointcut(classname as character, methodname as character, returntype as character, signature as character):
    
  end.
   
end class.