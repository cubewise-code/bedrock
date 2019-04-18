## Description
   
 This process will create client groups.  
     
**Use Case:**    Intended for development or production.  
1. Create initial security groups.  
2. Add security groups as business needs change.  
     
**Note:**     
 Naturally, a group (`pGroup`) is mandatory otherwise the process will abort.  
 - Multiple groups can be specified separated by a delimiter.  
 - If group already exists then the process will skip that group.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pGroup`|String||Required: Groups separated by delimiter|
  |`pDelim`|String|`&`|Optional: Delimiter character (Defaults to & if left blank)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
