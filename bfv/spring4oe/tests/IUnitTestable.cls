
using bfv.spring4oe.tests.UnitTestObject from propath.

interface bfv.spring4oe.tests.IUnitTestable:  
  
  define public property Value as character no-undo get. set.
  define public property Ref as UnitTestObject no-undo get. set.
  
  method public void Init().
  
end interface.