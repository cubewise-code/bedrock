## Description
   
 This process will Create a Top Level Hierarchy by N-Level Elements  that is a subset of all "top node" elements ( Consolidated elements that have no parents )  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension name|
  |`pHier`|String||Optional: Hierarchy name (default if blank = same named hierarchy)|
  |`pSub`|String||Required: Subset name|
  |`pConvertToStatic`|Numeric|`1`|Optional: Boolean: 1 = Convert to Static Subset|
  |`pAlias`|String||Optional: Set Alias for Subset|
  |`pTemp`|Numeric|`1`|Optional: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
