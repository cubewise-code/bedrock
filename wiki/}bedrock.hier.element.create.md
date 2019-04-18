## Description
   
 This process will create new element in a dimension Hierarchy. More elements than one will be  created if `pEle` is supplied with a delimited list of elements.  
     
**Note:**     
 Valid dimension name (`pDim`) and element list are mandatory, otherwise the process will abort.  
     
**:warning:Caution:** When target hierarchy is `Leaves`, no consolidated elements will be created.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: dimension name, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||Optional: hierarchy (default value same named hierarchy as dimension), accepts wildcards (if = *, then all hierarchies)|
  |`pEle`|String||Required: element name, accepts delimited list|
  |`pEleType`|String||Optional: element type N S C (default value N)|
  |`pInsertionPoint`|String||Optional: insertion point (default value blank)|
  |`pDelim`|String|`&`|Optional: delimiter character for element list. Defaults to & if blank|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
