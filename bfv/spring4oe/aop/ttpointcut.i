&if "{&ttpointcut{&postfix}-defined}" = "" &then

  &global-define ttpointcut{&postfix}-defined  true

  define {&accessor} temp-table~ 
    &if "{&postfix}" = "" &then ttpointcut &else ttpointcut{&postfix} &endif~
    &if "{&undo}" = "true" &then &else no-undo &endif   
    field id         as character
    field expression as character
    field classname  as character
    field methodname as character
    field returntype as character 
    field signature  as character
    .
    
&endif