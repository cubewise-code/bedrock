## Description
   
 This process can insert one or more attributes in one or more specified dimensions.  
     
**Use Case:**    Intended for development/prototyping.  
1. Add multiple dimension attributes.  
     
**Note:**     
 Delimited lists and/or wild card(*) are acceptable for `pDim` & `pAttr`.  
 Naturally, valid dimension name(s) (`pDim`) are mandatory otherwise the process will abort.  
 Known limitation: This process can insert multiple attributes to multiple dimensions but only for a single attribute type.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: dimension name, parameter accepts delimited list and wildcards|
  |`pAttr`|String||Required: attribute name, parameter accepts delimited list (separate with delimiter for multiple item e.g. Type&Active )|
  |`pPrevAttr`|String||Optional: insert position (previous attribute) (Defaults to blank)|
  |`pAttrType`|String||Optional: attribute type (e.g. A, S or N. If blank then assumed to be type=string)|
  |`pDelim`|String|`&`|Optional: delimiter character for attribute list. (Defaults to & if blank)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
