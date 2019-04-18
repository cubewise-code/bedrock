## Description
   
 This process will assign security to specified object(s) for specified group(s). Both `pGroup`  and `pObject` parameters support delimited lists and wildcards.  
     
**Use Case:**    Intended for develpment or production.  
 1. Set up initial security assignments.  
 2. Update security assignments a business needs change.  
     
**Note:**     
 Naturally, group (`pGroup`), object type (``pObject`Type`) and security level (`pSecurityLevel`) are mandatory otherwise the process will abort:  
 - Multiple groups can be specified separated by delimiter.  
 Object names (`pObject`) can be listed with delimiters but need to be valid as well.  
 - Before using this process, you must first initialise object security.  
 - For Applications, in Server Explorer go to Applications -> Security Assignments and assign an access security for an Application.  
 - For other object types follow a similar process but for that object type.  
 - Then from the Server Explorer go to your ServerName -> Security -> Refresh Security.  
 - Multiple objects can be specified separated by delimiter.  
 - If groups and/or objects that don't exist are specified, then they will be skipped but valid groups and ojects will still be processed.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pGroup`|String||Required: List of Groups Separated by Delimiter|
  |`pObjectType`|String||Required: Type of Object to Assign Security To (Application/Cube/Dimension/Process/Chore)|
  |`pObject`|String||Required: List of Objects Separated by Delimiter|
  |`pSecurityLevel`|String||Required: Security Level (Read/Write/Admin/None)|
  |`pSecurityRefresh`|String|`No`|Refresh Security? (Default = No)|
  |`pDelim`|String|`&`|Optional: Delimiter|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
