 
 /*------------------------------------------------------------------------
    File        : SessionManager
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Sun Nov 08 19:09:57 CET 2015
    Notes       : 
  ----------------------------------------------------------------------*/

using bfv.spring4oe.sample.ILogging from propath.

block-level on error undo, throw.

class bfv.spring4oe.sample.SessionManager: 
  
  define public property Logger as ILogging no-undo get. set.
  
  method public void InitObject():
    Logger:Log("injecting a reference works").
  end method.
  
end class.