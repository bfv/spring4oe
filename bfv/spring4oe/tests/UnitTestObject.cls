 
using bfv.spring4oe.tests.IUnitTestable.
using bfv.spring4oe.tests.UnitTestObject.


block-level on error undo, throw.

class bfv.spring4oe.tests.UnitTestObject implements IUnitTestable: 

	define public property Value as character no-undo get. set. 
  define public property Ref as UnitTestObject no-undo get. set.
		
	constructor public UnitTestObject (  ):
		super ().
	end constructor.

	method public void Init():
    this-object:Value = "ValueIsSet".
	end method.

end class.