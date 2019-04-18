## Description
   
 This process will clone the source dimension Hierarchy.  
     
**Use Case:**    Mostly in Development.  
1. Create a duplicate of an existing hierarchy for testing.  
     
**Note:**     
 Valid source dimension name (`pSrcDim`) and target dimension (`pTgtDim`) names are mandatory otherwise the process will abort.  
 Valid source hierarchy name (`pSrcHier`) is mandatory otherwise the process will abort.  
     
**:warning:Caution:**  - Target hierarchy cannot be `Leaves`.  
 - If the target dimension Hierarchy exists then it will be overwritten.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: Write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDim`|String||Required: Source Dimension|
  |`pSrcHier`|String||Required: Source Hierarchy|
  |`pTgtDim`|String||Required: Target Dimension (can be the same as source)|
  |`pTgtHier`|String||Optional: Target Hierarchy (will default to SrcHier_Clone if the dimensions are the same)|
  |`pAttr`|Numeric|`0`|Optional: Include Attributes? (Boolean 1=True)|
  |`pUnwind`|Numeric|`0`|Required:  Unwind? (0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements (Only relevant if target hierarchy exists) )|
  ## Full Process Dependencies
[}bedrock.hier.unwind](}bedrock.hier.unwind)  
