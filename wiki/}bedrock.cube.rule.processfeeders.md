## Description
   
 This process reprocesses feeders when consolidated totals are not adding up.  
     
**Use Case:**    Intended for Deveopment or production.  
1. This process would be used any time feeders need to be reprocessed (e.g. when new elements are added to any of the dimensions).  
     
**Note:**     
 Naturally, a valid  cube name (`pCube`) is mandatory otherwise the process will abort. Wildcards and lists are acceptable.  
 This process will process feeders for a cube.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Process feeders for this cube (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|Optional: Delimiter|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
