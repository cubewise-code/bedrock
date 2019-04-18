## Description
   
 This process deletes public views.  
     
**Use Case:**    Intended for development/prototyping or production.  
1. After a view has been created to zero or as a data source it needs to be deleted.  
2. Clean up public views after Go Live.  
     
**Note:**     
 This process can work on a single cubes or multiple cubes.  
 This process can work on a single view or multiple views.  
 When specifying view names wildcards can be included by using the * character.  
       **Parameter `pCube`**.  
   - To specify which cubes to delete views from use the `pCube`s parameter.  
   - To delete views from a single cube only just specify that cube name e.g. Sales.  
   - To delete views from multiple cubes specify each cube name separated by a delimiter e.g. Sales&Inventory&Cashflow.  
   - To delete views from all cubes then set `pCube`s as *.  
   - If any invalid cubes are specified they will be skipped but the process will continue to process the other cubes.  
       **Parameter `pView`**.  
   - To specify which views to delete use the `pView`s parameter.  
   - This parameter must be specified, a blank value will cause the process to terminate.  
   - To delete a single view only just specify that view name e.g. SalesByProduct.  
   - To delete multiple views specify each view name separated by a delimiter e.g. SalesByProduct&SalesByManager&SalesByStore.  
   - When specifying view names wildcards are permitted and all views that match the wildcard search string will be deleted.  
   - The wildcard search string follows the same format as windows based file wildcards.  
   - To delete all views that "start" with a specific string use a trailing * e.g. Bedrock*.  
   - To delete all views that "end" in a specific string use a leading * e.g. *Bedrock.  
   - To delete all views that "contain" a specific string use leading and trailing *'s e.g. *Bedrock*.  
   - To delete a single specific view only don't use *'s at all e.g. Bedrock.  
   - To specify multiple search stings list them all separated by a delimiter e.g. Bedrock*;*Temp;*Test*.  
   - Specific view names and wildcard based names can both be used together e.g. SalesByProduct;Bedrock*.  
       **Parameter `pDelim`**.  
   - The delimiter can be used when specifying multiple cubes and/or multiple views.  
   - The default delimiter is &.  
   - Any delimiter can be used by specifying a value for `pDelim`iter.  
   - Choose a delimiter that won't be used in either the wildcard search strings or cube names.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: List of Cubes Separated by Delimiter (For all cubes just the wildcard character alone i.e. *)|
  |`pView`|String|`}Bedrock*`|Required: List of Views Separated by Delimiter. Wildcards Permitted on View Names.|
  |`pDelim`|String|`&`|Delimiter Character|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
