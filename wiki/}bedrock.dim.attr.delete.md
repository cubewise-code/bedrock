## Description
   
 This process can delete one or more attributes in one or more specified dimensions.  
      
**Use Case:**    Intended for development/prototyping.  
 1. Clean up unused dimension attributes before going to production       
**Note:**     
 * Delimited lists and/or wild card(*) are acceptable for `pDim` & `pAttr`  * Multi-character wildcard "*" value for `pAttr` is evaluated as "ALL"  * You cannot specify "*" for **both** `pDim` and `pAttr`!   Warning:  
 1. As the process accepts wildcards USE WITH GREAT CARE! As if using wildcards for dimensions and attributes any matching attributes  in any matching dimensions will be removed from the system.  
 2. Multi-character wildcard "*" value for `pAttr` is evaluated as "ALL". Setting `pAttr` to "*" will delete all attributes in the spacified dimension.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: dimension name, parameter accepts delimited list and wildcards(*).|
  |`pAttr`|String||Required: attribute name, parameter accepts delimited list and wildcards (* = ALL).|
  |`pDelim`|String|`&`|Optional: delimiter character for attribute list. (Defaults to & if blank)|
  |`pCtrlObj`|Numeric|`0`|Required: Include control dimensions (1 = include, 0 = not include)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
