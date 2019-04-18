## Description
   
 This process deletes a dimension, list of dimensions, or set of dimensions specified by wildcard name match.  
     
**Use Case:**    Intended for development/prototyping.  
 1. During active agile development to remove dimensions due to renaming, change of requirements, etc.  
 2. Clean up unused dimensions prior to system Go Live.  
     
**Note:**     
 * A valid dimension name `pDim` or list thereof is mandatory otherwise the process will abort.  
 * Attribute dimensions are deliberately excluded because these are automatically cleaned up by removing the base dimension.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension (Delimited list & wildcards (*) acceptable)|
  |`pDelim`|String|`&`|Required: delimiter character for attribute list. (Defaults to & if blank)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
