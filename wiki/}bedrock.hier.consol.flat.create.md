## Description
   
 This process will add consolidated element `pTgtConsol` in the dimension hierarchy.  
     
**Use Case:**    Intended for Development but could be used in production too.  
1. Create a new hierarchy for testing.  
2. Create a new hierarchy to reflect new business needs.  
     
**Note:**     
 If source parent element (`pSrcConsol`) is defined then all its leaf elements will be copied to target  parent element consolidation. Otherwise all leaf elements in the dimension hierarchy will be  added into target parent element consolidation.  
 Valid source dimension name (`pDim`), hierarchy (`pHier`) and taget parent element (`pTgtConsol`)  
 are mandatory otherwise the process will abort.  
 Weight of all added elements into target parent consolidation will be assigned accoring to  `pWeight` parameter value.  
     
**:warning:Caution:** If the target pConsol exists in the hierarchy, then it will be overwritten.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension|
  |`pHier`|String||Optional: Hierarchy (will default to dimension name if blank)|
  |`pSrcConsol`|String||Optional: Source consolidated element name|
  |`pTgtConsol`|String||Required: Target consolidated element name|
  |`pWeight`|Numeric|`1`|Optional: Component Weight|
  ## Full Process Dependencies
[}bedrock.hier.unwind](}bedrock.hier.unwind)  
