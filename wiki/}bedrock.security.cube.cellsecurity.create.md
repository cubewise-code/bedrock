## Description
   
 This process will create a cell security cube for the specified cube for the specified list of dimensions.  
     
**Use Case:**    Intended for development.  
1. Set up initial security.  
     
**Note:**     
 Naturally, a valid cube (`pCube`) is mandatory otherwise the process will abort.  
 If cell security has already been set up the TI will abort.  
 The `pDim` parameter must map ALL the dimensions in order in the cube with a 0 or 1.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube to create cell security for|
  |`pDim`|String||Required: Map of dimensions to include in cell security as a array of 1:0 colon delimited e.g. "1:0:0:1:0"|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
