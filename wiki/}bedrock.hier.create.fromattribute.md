## Description
   
 This process will create a new dimension hierarchy from attribute values.  
     
**Note:**     
 Valid dimension name (`pDim`) and attribute name (`pAttr`) are mandatory, otherwise the  process will abort.  
     
**:warning:Caution:** It is assumed each element exists __only once__ within the hierarchy. This should hold true except in exceptional circumstances.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`1`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension|
  |`pSrcHier`|String||Optional: Source Hierarchy, If not specified takes the default Hierarchy|
  |`pTgtHier`|String||Optional: Target Hierarchy, If not specified, takes the same name as attribute.|
  |`pAttr`|String||Required: Attribute|
  |`pTopNode`|String|`Total <pAttr>`|Optional: The name of the Target Hierarchy top element (will default to 'All ' attribute name )|
  |`pPrefix`|String||Optional: Prefix before the attribute value|
  |`pSuffix`|String||Optional: Suffix after the attribute value|
  |`pSkipBlank`|Numeric|`0`|To manage empty attribute: 0= Skip,  1=Send to unallocated node|
  |`pUnallocated`|String|`Undefined <pAttr>`|Naming convention for rollup if  attribute is empty (eg. Unallocated <pAttr>, No <pAttr>, Undefined <pAttr>)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
