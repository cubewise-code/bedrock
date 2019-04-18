## Description
   
 This process will destroy the cell security cube(s) for the specified cube(s).  
     
**Use Case:**    Intended for development.  
1. Remove cell level security for one or more cubes.  
     
**Note:**     
 Naturally, a valid cube (`pCube`) is mandatory otherwise the process will abort.  
 If the cube does not have cell security set up, it will skip that cube but log an error.  
 Multiple cubes can be specified separated by the `pDelim` or by using wildcards (*).  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: List of Cubes (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|Optional: Delimiter (Defaults to & if left blank.)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
