## Description
   
 This process will backup & remove **OR** re-attach the rule file to cube.  
     
**Use Case:**    Intended to be used in production.  
1. Remove rule file before data load to speed up data load.  
2. Re-attach rule file after data load.  
     
**Note:**     
 Naturally, a valid cube name (`pCube`) is mandatory otherwise the process will abort.  
 The mandatory `pMode` parameter must be set to 'Unload' to remove/unload the rule file.  
 The `pMode` parameter must be set to 'Load' to re-attach the rule file and apply the rules.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube Name to Load/Unload rule (Separated by Delimiter, Accepts Wild card)|
  |`pMode`|String||Required: Load/Unload the cube rule (=Load, the file name should be available in the data directory with the required file name Suffix)|
  |`pFileName`|String||Optional: Full file name for storing the rule (if empty = cube name.txt)|
  |`pDelim`|String|`;`|Optional: Delimiter|
  |`pPath`|String||Optional: Saves the file and the backup of the existing rule in this location. If Null, backup will be saved in Data Directory. Default value Null|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
