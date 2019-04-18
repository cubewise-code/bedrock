## Description
   
 This process will copy a subset from a Hierarchy in source Dimension to a Hierarchy in target  Dimension.  
     
**Note:**     
 Valid source dimension name (`pSrcDim`), source (`pSrcSub`) and target subset (`pTgtSub`) are  mandatory otherwise the process will abort.  
     
**:warning:Caution:**  - Target hierarchy cannot be `Leaves`.  
 - If the target dimension Hierarchy exists then it will be overwritten.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDim`|String||Required: Dimension where the subset exists|
  |`pSrcHier`|String||Optional: Source Hierarchy (blank = same as source)|
  |`pSrcSub`|String||Required: Source Subset|
  |`pTgtDim`|String||Optional: Target dimension (blank = same as source)|
  |`pTgtHier`|String||Optional: Target Hierarchy (blank = same as Target Dimension)|
  |`pTgtSub`|String||Required: Target Subset|
  |`pTemp`|Numeric|`1`|Optional: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
