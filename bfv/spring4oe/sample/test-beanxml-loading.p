
define variable xdoc as handle no-undo.
define variable success as logical no-undo.

create x-document xdoc.


success = xdoc:load("file", "./bfv/spring4oe/sample/beans.xml", true).
message success view-as alert-box.

catch err1 as Progress.Lang.Error :
	clipboard:value = err1:GetMessage(1).	
	message "done" err1:GetMessage(1) view-as alert-box.
end catch.