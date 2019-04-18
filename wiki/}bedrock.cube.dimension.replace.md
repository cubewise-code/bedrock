## Description
   
 This TI deletes a dimension and adds another one to an existing cube with the ability to preserve data.  
     
**Use Case:**    Intended for development/prototyping.  
1. Rebuild existing cube after removal of one dimension and adding anothr one without losing all the data.  
     
**Note:**     
 Naturally, a valid cube name (`pCube`) is mandatory otherwise the process will abort.  
 Also, valid dimension names (`pSrcDim` & `pTgtDim`) are mandatory otherwise the process will abort.  
 When data needs to be kept (using `pIncludeData`) a valid element (`pEle`) in new dimension must be specified  where to store the data. Data is summed from original dimension.  
 Rule can be kept as backup file only or reloaded back.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube|
  |`pSrcDim`|String||Required: Dimension to be replaced|
  |`pTgtDim`|String||Required: Replacement Dimension|
  |`pIncludeData`|Numeric|`0`|Required: If 1 then data is kept (copied through clone cube)|
  |`pEle`|String||Required: If pIncludeData =1: Element in target dimension to load data to|
  |`pIncludeRules`|Numeric|`0`|Required: Unload and reload the rule (0 = do not keep the rule, 1 = unload the rule, 2 = unload the rule and reload on new cube)|
  |`pCtrlObj`|Numeric|`0`|Required: Allow overwrite control cubes|
  |`pTemp`|Numeric|`1`|Required: Delete the clone cube (1 = delete, 0 = not delete)|
  ## Full Process Dependencies
[}bedrock.cube.clone](}bedrock.cube.clone)  
[}bedrock.cube.create](}bedrock.cube.create)  
[}bedrock.cube.data.clear](}bedrock.cube.data.clear)  
[}bedrock.cube.data.copy.intercube](}bedrock.cube.data.copy.intercube)  
[}bedrock.cube.delete](}bedrock.cube.delete)  
[}bedrock.cube.rule.manage](}bedrock.cube.rule.manage)  
[}bedrock.cube.view.create](}bedrock.cube.view.create)  
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
