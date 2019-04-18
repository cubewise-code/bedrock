## Description
   
 This process will Create a dynamic subset from an MDX expression that evaluates to a non-empty set in the specified dimension.  
     
**Use Case:**    Intended for Production & Development 1/ Create a dynamic subset for use in a view      
**Note:**     
 Naturally, valid dimension name (`pDim`) are mandatory otherwise the process will abort.  
 If the MDX does not compile or produces an empty set, the process will error.  
 If convert to static (`pConvertToStatic`) is set to 1 then the MDX subset will be replaced by a static subset.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension name|
  |`pHier`|String||Optional: Hierarchy name (default if blank = same named hierarchy)|
  |`pSub`|String||Required: Subset name|
  |`pMDXExpr`|String||Required: Valid MDX Expression for Specified Dimension|
  |`pConvertToStatic`|Numeric|`1`|Optional: Bolean: 1 = True (convert to static subset)|
  |`pTemp`|Numeric|`1`|Optional: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
