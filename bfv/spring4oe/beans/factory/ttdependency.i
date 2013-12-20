&if "{&ttdependency-defined}" = "" &then

  &global-define ttdependency-defined  true

  define {&accessor} temp-table ttdependency &if "{&undo}" = "true" &then &else no-undo &endif          /* no-undo? */
    field beanname   as character
    field references as character
    field singleton  as logical
    .
    
&endif
    