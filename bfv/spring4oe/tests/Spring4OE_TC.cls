 
 /*------------------------------------------------------------------------
    File        : Spring4OE_TC
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Mon Nov 09 07:47:26 CET 2015
    Notes       : 
  ----------------------------------------------------------------------*/

using Progress.Lang.Object.
using bfv.spring4oe.beans.factory.XmlBeanFactory from propath.
using OpenEdge.Core.Assert from propath.
using bfv.spring4oe.tests.IUnitTestable from propath.

block-level on error undo, throw.

class bfv.spring4oe.tests.Spring4OE_TC:
	
  define private variable factory as XmlBeanFactory no-undo.
  
  @Before.
	method public void SetupBeforeClass(  ):
		factory = new XmlBeanFactory("./bfv/spring4oe/tests/testcases.xml").
	end method.
	
	@test.
	method public void Instantiating_simple_object():
	  
	  define variable obj as Object no-undo.
	  
	  obj = factory:GetBean("simpleobject").
	  
	  Assert:isTrue(valid-object(obj)).
    
	end method.
	
	@test.
	
  @test.
  method public void Instantiating_simple_object_twice_gives_new_object():
    
    define variable obj1 as Object no-undo.
    define variable obj2 as Object no-undo.
    
    obj1 = factory:GetBean("simpleobject").
    obj2 = factory:GetBean("simpleobject").
    
    Assert:isFalse(obj1:Equals(obj2)).
    
  end method.
  
  
  @test.
  method public void Instantiating_singleton_returns_object():
    
    define variable obj as Object no-undo.
    
    obj = factory:GetBean("singleton").
    
    Assert:isTrue(valid-object(obj)).
    
  end method.

  @test.
  method public void Instantiating_singleton_twice_returns_same_object():
    
    define variable obj1 as Object no-undo.
    define variable obj2 as Object no-undo.
    
    obj1 = factory:GetBean("singleton").
    obj2 = factory:GetBean("singleton").
    
    Assert:isTrue(obj1:Equals(obj2)).
    
  end method.
  
  @test.
  method public void Instantiating_singleton_and_protype_of_same_type():
    
    define variable obj1 as Object no-undo.
    define variable obj2 as Object no-undo.
    
    obj1 = factory:GetBean("simpleobject").
    obj2 = factory:GetBean("singleton").
    
    Assert:isFalse(obj1:Equals(obj2)).
    
  end method.
  
  @test.
  method public void Alias_on_singleton_returns_same_instance():
    
    define variable obj1 as Object no-undo.
    define variable obj2 as Object no-undo.
    
    obj1 = factory:GetBean("singleton").
    obj2 = factory:GetBean("singleton2").
    
    Assert:isTrue(obj1:Equals(obj2)).
    
  end method.
  
  @test.
  method public void InitMethod_is_called():
    
    define variable obj as IUnitTestable no-undo.
    
    obj = cast(factory:GetBean("initobject"), "bfv.spring4oe.tests.IUnitTestable").
    
    Assert:Equals(obj:Value, "ValueIsSet").
    
  end method.
	  
  @test.
  method public void Property_value_is_set():
    
    define variable obj as IUnitTestable no-undo.
    
    obj = cast(factory:GetBean("propertyobject"), "bfv.spring4oe.tests.IUnitTestable").
    
    Assert:Equals(obj:Value, "ValueViaProperty").
    
  end method.
  
  @test.
  method public void Proprty_ref_is_set():

    define variable obj as IUnitTestable no-undo.
    
    obj = cast(factory:GetBean("refpropertyobject"), "bfv.spring4oe.tests.IUnitTestable").
    
    Assert:Equals(obj:Ref:Value, "ValueIsSet").
    
  end method.
  
end class.