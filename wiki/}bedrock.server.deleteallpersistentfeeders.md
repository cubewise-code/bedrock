## Description
   
 This process will Delete Persistent feeders.  
     
**Use Case:**    Intended for development or production.  
1. Persistent feeders turned off in config file.  
2. Want to reprocess feeders.  
     
**Note:**     
 Reprocessing feeders could take a long time and it may be better to run this overnight.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pRun`|String|`Y`|Optional: Do you want to delete Persistent Feeders? (Y or N)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
