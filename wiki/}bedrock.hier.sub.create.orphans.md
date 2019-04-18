## Description
   
 This process will create a static subset in a Hierarchy of target Dimension that consists of  all orphan elements.  
     
**Note:**     
 Orphan element is defined as:  
 - Consolidated element without children.  
 - Leaf element without parent.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension name|
  |`pHier`|String||Optional: Hierarchy name (default if blank = same named hierarchy)|
  |`pTemp`|Numeric|`1`|Optional: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
