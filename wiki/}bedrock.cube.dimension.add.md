## Description
   
 This TI adds a dimension to a cube that has already been built with the ability to preserve data.  
     
**Use Case:**    Intended for development/prototyping.  
1. Rebuild existing cube with extra dimension without losing data.  
     
**Note:**     
 Naturally, a valid target cube name (`pCube`) is mandatory otherwise the process will abort.  
 Also, a valid new dimension name (`pDim`) is mandatory otherwise the process will abort.  
 When data needs to be kept (using `pIncludeData`) a valid element (`pEle`) must be specified where to store the data in new dimension.  
 Rule can be kept as backup file only or reloaded back.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube name|
  |`pDim`|String||Required: Dimension to be added|
  |`pIncludeData`|Numeric|`0`|If 1 then data is kept (copied through clone cube)|
  |`pEle`|String||Required if IncludeData flag =1: Element of new dimension where to store data|
  |`pDimIndex`|Numeric|`1`|Required: Dimension number of the new dimension in the cube|
  |`pIncludeRules`|Numeric|`2`|Unload and reload the rule (0 = do not keep the rule, 1 = unload the rule, 2 = unload the rule and reload on new cube)|
  |`pCtrlObj`|Numeric|`0`|Allow overwrite control cubes|
  |`pTemp`|Numeric|`1`|Delete the clone cube (1 = delete, 0 = not delete)|
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
