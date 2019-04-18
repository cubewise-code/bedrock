## Description
   
 In certain circumstances the Leaves hierarchy can become *out of sync* with the same named hierarchy and other alternate hierarchies  and *not contain all leaf elements*. Should this happen this process will heal such dimensions and restore the synced state where  the Leaves hierarchy contains the collection of all leaf elements from all hiearchies of a dimension.  
 For the set of dimensions and hierarchies defined by the `pDim` & `pHier` parameters this process checks that all leaf elements from each  hierarchy also exists in the Leaves hierarchy of the specified dimension(s).  
  If the leaf element does not exist in the Leaves hierarchy then the element is inserted into Leaves.  
      
**Use Case:**     
 1. Primarily intended to identify dimensions with maintenance issues during development/prototyping.  
 2. Can also be used for trouble-shooting in productive instances.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||Optional: Hierarchy, accepts wildcards (all hierarchies except default and Leaves deleted if = *)|
  |`pDelim`|String|`&`|Optional: Delimiter character|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
