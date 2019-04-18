## Description
   
 This process automatically creates a cube based on a delimited string of dimension names.  
     
**Use Case:**    Intended for development/prototyping.  
1. This can be used to quickly create a cube for a demo or development.  
     
**Note:**     
 The `pDims` parameter contains the dimenson list and is mandatory.  
 The format of the `pDims` parameter is as follows for delimiter of '&' (e.g. Dim1 & Dim2 & Dim3 ).  
 Spaces are ignored so use them to make your filter more readable.  
 The order of the dimension list specifies the initial index order of dimensions in the cube.  
 `pRecreate` is an optional parameter for creating new cubes:  
 - If a cube already exists and `pRecreate` is set to 0 then the process will abort.  
 - If a cube already exists and `pRecreate` is set to 1 then the process will destroy the old cube and recreate with the specified dimensionality.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube Name|
  |`pDims`|String||Required: Dim1+ Dim2 + Dim3 + Dim4 + Dim5|
  |`pRecreate`|Numeric|`0`|Optional: If cube exists delete and recreate (Default=0)|
  |`pDelim`|String|`+`|Optional: Delimiter for Dimension list|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
