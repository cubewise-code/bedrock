## Description
   
 This process checks all leaf elements (in the Leaves hierarchy) of the specified dimension(s).  
 Within the Leaves hierarchy for each element *all hierarchies* are scanned for the existance of the leaf element.  
 If the leaf element does not exist in all hierarchies except for Leaves then the element is classified as an orphan and added to the  "Orphan Leaf Elements" subset.  
 Additionally when running with `pIncludeNoParentElems` parameter set, elements that have no parent will be stored in No Parents subset  of matching hierarchy (except `Leaves`) within Leaves. The subset name might be accomodated and will be suffixed by dash and name of the matching hierarchy.  
      
**Use Case:**     
 1. Primarily intended to identify dimensions with maintenance issues during development/prototyping.  
 2. Can also be used for trouble-shooting in productive instances.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String|`*`|Optional: Hierarchy, accepts wildcards (all hierarchies except default and Leaves deleted if = *)|
  |`pTgtSubLeaves`|String|`Bedrock - Orphan Elements - Leaves`|Optional: Name of target subset to store orphans in Leaves hierarchy|
  |`pIncludeNoParentElems`|Numeric|`0`|Optional: Include elements that have no parent in any of matching hierarchies|
  |`pTgtSubNoParents`|String|`Bedrock - No Parents`|Optional: Name of target subset to store elements that have no parent in any of matching hierarchies|
  |`pDelim`|String|`&`|Optional: Delimiter character|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
