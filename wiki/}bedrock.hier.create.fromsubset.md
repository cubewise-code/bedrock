## Description
   
 This process will make a copy of an existing dimension subset, creating it as a new dimension hierarchy.  
     
**Use Case:**    Intended for Development but could be used in production too.  
 1. Create a new hierarchy for testing.  
 2. Create a new hierarchy to reflect new business needs.  
     
**Note:**     
 Valid source dimension name (`pSrcDim`) and source subset (`pSubset`) are mandatory, otherwise the process will abort.  
 If a source hierarchy name (`pSrcHier`) is specified, it needs to be valid, otherwise the process will abort.  
     
**:warning:Caution:**  - Target hierarchy cannot be Leaves.  
 - If the target Hierarchy already exists, then it will be overwritten.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDim`|String||Required: Source Dimension|
  |`pSrcHier`|String||Optional: Source Hierarchy (blank = same name as source dimension)|
  |`pSubset`|String||Required: Source Subset|
  |`pTgtDim`|String||Optional: Target Dimension (blank = same name as source dimension)|
  |`pTgtHier`|String||Optional: Target Hierarchy (blank = same name as target dimension)|
  |`pAttr`|Numeric|`1`|Optional: Include Attributes? (Boolean 1=True)|
  |`pUnwind`|Numeric|`0`|Optional: 0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements|
  |`pFlat`|Numeric|`0`|Optional: Whether to create flat hierarchy? (1 = Yes, 0 = No)|
  ## Full Process Dependencies
[}bedrock.cube.data.clear](}bedrock.cube.data.clear)  
[}bedrock.cube.data.copy](}bedrock.cube.data.copy)  
[}bedrock.cube.view.create](}bedrock.cube.view.create)  
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
[}bedrock.hier.unwind](}bedrock.hier.unwind)  
