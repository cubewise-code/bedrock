## Description
   
 This process will delete client groups.  
     
**Use Case:**    Intended for development or production.  
1. Clean up security groups after go live.  
2. Delete obsolete security groups as business needs change.  
     
**Note:**     
 Naturally, a group (`pGroup`) is mandatory otherwise the process will abort:  
 - Multiple groups can be specified separated by a delimiter.  
 - If group does not exist then it will be skipped.  
 - If multiple groups are specified and some don't exist and some do, then the ones that do exist will still be deleted.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pGroup`|String||Required: Groups (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|Optional: Delimiter character (Defaults to & if left blank)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
