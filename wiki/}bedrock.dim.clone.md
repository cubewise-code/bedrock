## Description
   
 This process can clone a source dimension and all the Hierarchies.  
     
**Use Case:**    Intended for development/prototyping.  
1. Replicate a dimension with it's hierarchies for testing.  
     
**Note:**     
 If the target dimension:hierarchy already exists then it will be overwritten.  
 Naturally, a valid source dimension name (`pSrcDim`) is mandatory otherwise the process will abort.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDim`|String||Required: Source Dimension|
  |`pTgtDim`|String||Optional: Target Dimension (will default to pSrcDim_clone If blank (or) is same as pSrcDim)|
  |`pHier`|String|`*`|Required: Hierarchies to be included (will use default is left blank), accepts wildcards (if = *, then all hierarchies)|
  |`pAttr`|Numeric|`0`|Required: Include Attributes? (Boolean 1=True)|
  |`pUnwind`|Numeric|`0`|Required: 0 = Delete all Elements, 1 = Unwind Existing Elements, 2 = Do not change Existing Elements|
  |`pDelim`|String|`&`|Optional: delimiter character for element list (required if pEle parameter is used)|
  ## Full Process Dependencies
[}bedrock.hier.clone](}bedrock.hier.clone)  
[}bedrock.hier.unwind](}bedrock.hier.unwind)  
