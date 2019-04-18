## Description
   
 This process will swap the values of the nominated alias with the principal name for all elements of the target dimension.  
      
**Use Case:**    Strictly for development/prototyping scenarios. This process should **not be used** in a production environment.  
 1. Swap an alias with principal name       
**Note:**     
 The Swa`pAlias`WithPrincipalName function is **not supported** for alternate hierarchies. Therefore this process checks for the  existance of alternate hierarches and if any exist for the target dimension then the process will abort.  
  Warning:  
 Use with care. This process works, however, the underlying Swa`pAlias`WithPrincipalName function  has never been officially  documented or suported by IBM.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Required: True or False (Boolean True = 1)|
  |`pDim`|String||Required: Dimension name|
  |`pAlias`|String||Required: Alias|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
