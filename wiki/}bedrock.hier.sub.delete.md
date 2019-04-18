## Description
   
 This process deletes public subsets from selected dimension and hierarchies. Dimensions, hierarchies  and subsets can be specified as a delimited list. Wildcards are accepted as `*` and `?` characters.  
     
**Note:**     
 - `pDim`: To specify which dimensions to delete subsets from use the `pDim` parameter.  
   - To delete subsets from a single dimension only just specify that dimension name e.g. `Product`.  
   - To delete subsets from multiple dimensions specify each dimension name separated by a delimiter      e.g. `Product & Customer & Account`.  
   - To delete subsets from all dimensions then leave `pDim` parameter blank or supply `ALL`.  
   - If any invalid dimensions are specified they will be skipped but the process will continue to      process the other dimensions.  
   - When specifying dimension names wildcards are permitted and all dimensions that match the      wildcard search string will be searched - for syntax see below `pSub` parameter.  
 - `pHier`: To specify which hierarchies to delete subsets from use the `pHier` parameter.  
   - To specify default hierachy, leave parameter value empty.  
   - To specify all available hierarchies, set parameter value to `*`.  
   - When specifying hierarchy names wildcards are permitted and all hierachies that match the wildcard      search string will be searched - for syntax see below `pSub` parameter.  
 - `pSub`: To specify which subsets to delete use the `pSub` parameter.  
   - This parameter must be specified, a blank value will cause the process to terminate.  
   - To delete a single subset only just specify that subset name e.g. `SmallProducts`.  
   - To delete multiple subsets specify each subset name separated by a delimiter      e.g. `SmallProducts & LargeProducts`.  
 - `pDelim`: The delimiter is used when specifying multiple dimensions and/or multiple subsets.  
   - The default delimiter is `&`.  
   - Any delimiter can be used by specifying a value for `pDelim`.  
   - Choose a delimiter that won't be used in either the wildcard search strings or dimension names.  
 - `pMode`:  
   - When set to value less or equal to `1`: all found subsets will be destroyed.  
   - When set to value of `2`: all found subsets will be emptied.  
 __Example__:  
 - When specifying subset names wildcards are permitted and all subsets that match the wildcard    search string will be deleted:  
     - The wildcard search string follows the same format as wildcards used in Subset Editor.  
     - To delete all subsets that __start__ with a specific string use a trailing `*` e.g. `Bedrock*`.  
     - To delete all subsets that __end__ in a specific string use a leading `*` e.g. `*Bedrock`.  
     - To delete all subsets that __contain__ a specific string use leading and trailing `*`'s e.g. `*Bedrock*`.  
     - To delete a single specific subset only don't use `*`'s at all e.g. `Bedrock`.  
     - To specify multiple search stings list them all separated by a delimiter e.g. `Bedrock* & *Temp & *Test*`.  
     - Similarly you can use `?` as wildcard specifying one character - usage is similar as above specified examples for `*`.  
     - Specific subset names and wildcard based names can both be used together e.g. `SalesByProduct;Bedrock*`  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Optional: Dimension name (if * then ALL dimensions )|
  |`pHier`|String||Optional: Hierarchy name (if * then ALL hierarchies for the specified dimensions)|
  |`pSub`|String|`}Bedrock*`|Required: Filter on subsets (delimiter separated list of subset names, accepts wildcards)|
  |`pDelim`|String|`&`|Optional: Delimiter character for subset list (required if pSub parameter is used)|
  |`pMode`|Numeric|`0`|Optional: <=1 destroy subset, 2 delete all elements|
  ## Full Process Dependencies
[}bedrock.hier.sub.delete](}bedrock.hier.sub.delete)  
