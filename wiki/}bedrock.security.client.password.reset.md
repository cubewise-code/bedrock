## Description
   
 This process can be used by admins to reset a client password.  
     
**Use Case:**    Intended for production.  
1. When a user has forgotten his/her password this TI can be used to reset it.  
     
**Note:**     
 Naturally, a valid client(s) (`pClient`) is mandatory otherwise the process will abort.  
 Multiple clients can be specified separated by a delimiter.  
 It has to be run by an ADMIN person otherwsie it will abort.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pClient`|String||Required: Clients (Separated by delimiter (e.g. Client1&Client2), Accepts Wild card (e.g. *Client,*Client*, Client*))|
  |`pPassword`|String||Required: New Password|
  |`pDelim`|String|`&`|Optional: Delimiter character|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
