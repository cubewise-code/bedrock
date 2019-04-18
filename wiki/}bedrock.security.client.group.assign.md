## Description
   
 This process will assign Client and Group Security.  
     
**Use Case:**    Intended for production.  
1. After adding new user(s) using '}bedrock.security.client.create' they must be assigned to groups.  
     
**Note:**     
 Naturally, valid  client (`pClient`) is mandatory otherwise the process can't make assignments:  
 - This process can either add or remove clients to groups based on `pAddOrRemove`.  
 - This process can work on a single client or multiple clients separated by a delimiter.  
 - This process can work on a single group or multiple groups separated by a delimiter.  
 - Therefore, it can be used to:  
   - Add/remove a single client to/from a single group.  
   - Add/remove many clients to/from a single group.  
   - Add/remove a single client to/from many groups.  
   - Add/remove many clients to/from many groups.  
 - The caller can choose whether or not to refresh security at the end. Default is yes.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pClient`|String||Required: Client Names Separated by Delimiter and accepts wildcards|
  |`pGroup`|String||Required: Group Names Separated by Delimiter and excepts wildcards|
  |`pDelim`|String|`&`|Optional: Delimiter|
  |`pAddOrRemove`|String|`Add`|Required: Add or Remove|
  |`pSecurityRefresh`|String|`Yes`|Required: Refresh Security?|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
