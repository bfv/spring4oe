class bfv.spring4oe.aop.Pointcut:
  
  define public property Classname  as character no-undo get. private set.
  define public property Methodname as character no-undo get. private set.
  define public property ReturnType as character no-undo get. private set.
  define public property Signature  as character no-undo get. private set.
  
  constructor public PointCut(expr as character):
    
    ReturnType = "".
  end.
  
end class.