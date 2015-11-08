 
 /*------------------------------------------------------------------------
    File        : FactoryMethodSample
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : bronco
    Created     : Sun Nov 08 20:18:30 CET 2015
    Notes       : 
  ----------------------------------------------------------------------*/

using bfv.spring4oe.sample.FactoryMethodSample.


block-level on error undo, throw.

class bfv.spring4oe.sample.FactoryMethodSample: 
  
  method public static FactoryMethodSample GiveMeAnInstance():
    return new FactoryMethodSample().
  end method. 
  
end class.
