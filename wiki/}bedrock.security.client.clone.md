## Description
   
 This process will copy security from one user to another. Target client(s) will be created if it doesn't exist.  
     
**Use Case:**    Intended for production.  
1. When a company hires new employees their profile can be set up by cloning an existing employee.  
     
**Note:**     
 Naturally, a valid source client (`pSrcClient`) is mandatory otherwise the process will abort.  
 Also, a valid target client(s) (`pTgtClient`) must be specified, otherwise the process will abort:  
 - Multiple target clients can be specified separated by a delimiter.  
 - If target client doesn't already exist then Bedrock.Security.Client.Create will be called.  
 - The process has 2 modes REPLACE (default) clears any existing group memberships. ADD only adds new ones.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcClient`|String||Required: Source Client|
  |`pTgtClient`|String||Required: List of Target Clients Separated by Delimiter|
  |`pMode`|String|`REPLACE`|Optional: Mode REPLACE or ADD (default = REPLACE)|
  |`pDelim`|String|`&`|Optional: Delimiter (Use for a list of target users. Defaults to & if blank.)|
  ## Full Process Dependencies
[}bedrock.security.client.create](}bedrock.security.client.create)  
