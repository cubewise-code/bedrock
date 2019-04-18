## Description
   
 This process will delete clients.  
     
**Use Case:**    Intended for development and production.  
1. Clean up users after go live.  
2. Remove old employees from the system on termination.  
     
**Note:**     
 Naturally, a valid client(s) (`pClient`) is mandatory otherwise the process will abort:  
 - Multiple clients can be specified separated by a delimiter.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pClient`|String||Required: Clients (Separated by delimiter (e.g. Client1&Client2), Accepts Wild card (e.g. *Client,*Client*, Client*))|
  |`pDelim`|String|`&`|Optional: Delimiter|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
