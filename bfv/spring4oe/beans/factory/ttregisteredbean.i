&if "{&ttregisteredbean-defined}" = "" &then

  &global-define ttregisteredbean-defined  true

  define {&accessor} temp-table ttregisteredbean &if "{&undo}" = "true" &then &else no-undo &endif          /* no-undo? */
    field beanname       as character
    field beandefinition as Progress.Lang.Object
    field referenced     as integer
    .
    
&endif