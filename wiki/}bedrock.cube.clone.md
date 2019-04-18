## Description
   
 This process replicates an existing cube. It can include data & rules too.  
     
**Use Case:**    Intended for development/prototyping.  
 1. Take a snapshot of cube data copying all rules to values.  
 2. Take an exact copy of a cube in a "one click action" as a starting point for prototyping rule changes or developing new features.  
     
**Note:**     
 * There are parameter options to include data (`pIncludeData`) and rules (`pIncludeRules`) with the creation of the cube.  
 * If the source cube (`pSrcCube`) is left blank or doesn't exist in the model, process will terminate withoud doing anything.  
 * If the target cube (`pTgtCube`) already exists in the model, process will terminate withoud doing anything.  
 * If the target cube is left blank or is the same as the source cube the cloned cube will inherit the source cube name with "_Clone" appended.  
 * If the source cube data only needs to be partially copied, then the `pFilter` parameter should be entered otherwise all other parameters can be left as is.  
 * In productive systems this process may be called internally by other processes (}bedrock.cube.data.copy, }bedrock.cube.data.copy.intercube) if copying data via intermediate cloned cube.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|OPTIONAL: write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcCube`|String||REQUIRED: Source Cube|
  |`pTgtCube`|String||OPTIONAL: Target Cube to create/re-create (Source cube_clone if left blank)|
  |`pIncludeRules`|Numeric|`1`|REQUIRED: Include cube rules? (Boolean Yes = 1)|
  |`pIncludeData`|Numeric|`0`|REQUIRED: Include cube data? (Boolean Yes = 1)|
  |`pFilter`|String||OPTIONAL: Filter on source cube in format Year: 2006 + 2007 & Scenario: Actual + Budget. Blank for whole cube|
  |`pDimDelim`|String|`&`|OPTIONAL: Delimiter for start of Dimension/Element set|
  |`pEleStartDelim`|String|`¦`|OPTIONAL: Delimiter for start of element list|
  |`pEleDelim`|String|`+`|OPTIONAL: Delimiter between elements|
  |`pSuppressRules`|Numeric|`1`|REQUIRED: Skip rule values? (1=skip)|
  |`pTemp`|Numeric|`1`|REQUIRED: Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )|
  |`pCubeLogging`|Numeric|`0`|REQUIRED: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)|
  ## Full Process Dependencies
[}bedrock.cube.create](}bedrock.cube.create)  
[}bedrock.cube.data.clear](}bedrock.cube.data.clear)  
[}bedrock.cube.data.copy.intercube](}bedrock.cube.data.copy.intercube)  
[}bedrock.cube.view.create](}bedrock.cube.view.create)  
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
