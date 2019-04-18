## Description
   
 This process will create a static subset in a Hierarchy of target Dimension that consists of  all descendants of a specified consolidated element, including consolidated elements.  
     
**Note:**     
 - `pExclusions`: If `pExclusions` is specified then the elements (separated by a delimiter) will be    excluded from the subset. Wildcards characters `*` and `?` are accepted.  
 - `pAddToSubset` : If the specified subset already exists then this parameter will control whether    elements will be added to the existing subset (value 1) or a new subset will be created    (value 0).  
     
**:warning:Caution:** Number of consolidated levels that are processed is limited to maximum of 99.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension name|
  |`pHier`|String||Optional: Hierarchy name (default if blank = same named hierarchy)|
  |`pSub`|String||Required: Subset name|
  |`pConsol`|String||Optional: Consolidated Element  (Blank Equals All)|
  |`pAddToSubset`|Numeric|`0`|Optional: Add to Subset if it Already Exists (0=No 1=Yes)|
  |`pExclusions`|String||Optional: Elements to Exclude From Subset (Separated by Delimiter, Accepts Wild card)|
  |`pDelim`|String|`&`|Optional: Delimiter character|
  |`pAlias`|String||Optional: Set Alias for Subset|
  |`pTemp`|Numeric|`1`|Optional: Use temporary objects? (Boolean 1=True)|
  ## Full Process Dependencies
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
