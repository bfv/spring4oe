 
using bfv.spring4oe.sample.FactoryMethodSample.


block-level on error undo, throw.

class bfv.spring4oe.sample.FactoryMethodSample: 
  
  method public static FactoryMethodSample GiveMeAnInstance():
    return new FactoryMethodSample().
  end method. 
  
end class.
