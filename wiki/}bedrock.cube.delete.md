## Description
   
 This process deletes cube(s).  
     
**Use Case:**    Intended for cleaning up after development/prototyping.  
 1\ Delete all cubes not needed after Go Live.  
     
**Note:**     
 A list of cubes can be specified and/or wild cards can be used.  
 Naturally valid cube name(s) must be specified otherwise the process will abort.  
 By default (`pCtrlObj`) the process will not delete control cubes (i.e. attributes, security etc).  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: List of Cubes to Delete (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|Optional: Delimiter|
  |`pCtrlObj`|Numeric|`0`|Optional: to Delete control cube 1= Delete control objects, 0 = Not to delete control objects, Default value 0|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
