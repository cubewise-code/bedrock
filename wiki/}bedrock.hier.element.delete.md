## Description
   
 This process will delete specified or all elements from a dimension Hierarchy. Elements might be  specified as a delimited list of elements. Each member in the list might be specified exactly or  by a wildcard pattern. Wildcards `*` and `?` are accepted.  
     
**Note:**     
 Valid dimension name (`pDim`) otherwise the process will abort.  
     
**:warning:Caution:** When `pEle` is empty, __all__ elements in `pHier` will be deleted!  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: dimension name, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||Optional: hierarchy name (if blank then same named hierarchy as dimension is assumed), accepts wildcards (if = *, then all hierarchies)|
  |`pEle`|String||Optional: filter on elements (delimiter separated list of elements, accepts wildcards (if = *, then all the elements in hierarchy get deleted))|
  |`pDelim`|String|`&`|Optional: delimiter character for element list (required if pEle parameter is used)|
  ## Full Process Dependencies
[}bedrock.hier.sub.delete](}bedrock.hier.sub.delete)  
