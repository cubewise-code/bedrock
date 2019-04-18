## Description
   
 This process will create a new hierarchy `pHier` in target dimension `pDim`.  
     
**Use Case:**    Intended for Development but could be used in production too.  
1. Create a new hierarchy for testing.  
2. Create a new hierarchy to reflect new business needs.  
     
**Note:**     
 If dimension `pDim` doesn't exist, it will be created.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||Optional: Hierarchy, accepts delimited list|
  |`pDelim`|String|`&`|Optional: delimiter character for element list. Defaults to & if blank|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
