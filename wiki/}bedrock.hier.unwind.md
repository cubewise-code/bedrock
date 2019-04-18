## Description
   
 This process will remove all children from a specific target consolidation (`pConsol`) in a Hierarchy  in target Dimension. If recursive (`pRecursive`=1), it will also unwind all consolidations that are  descendants of the target regardless of depth. If not recursive (`pRecursive`=0) then only immediate children  of the target consolidation will be removed.  
      
**Use Case:**    Intended for both production and development/prototyping scenarios.  
 1. **Production** call prior to main dimension build process in case mapping relationships have changed to ensure no double-counting steming from leaf elements  rolling into multiple parents within the same rollup or hierarhcy  2. **Production** combine with }bedrock.hier.emptyconsols.delete to remove orphaned rollups  3. **Development** manual cleanup of dimensions during prototyping or prior to going to production       
**Note:**     
 Valid source dimension name (`pDim`) is mandatory otherwise the process will abort.  
 A blank `pHier` parameter will process the default hierarchy (i.e. of the same name as the dimension) for each of the dimensions processed.  
 A * `pConsol` parameter will process ALL C level items in the given hierarchy (`pHier`).  
      
**:warning:Caution:** If consolidations are also used in unrelated consolidations and recursive is selected this  will result in orphan consolidations in the other hierarchies.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Target Dimension, accepts wildcards (if = *, then all the dimensions)|
  |`pHier`|String||Optional: Target Hierarchy (will use default is left blank), accepts wildcards (if = *, then all hierarchies)|
  |`pConsol`|String|`*`|Optional: Target Consolidation, accepts wildcards ( * will unwind ALL)|
  |`pRecursive`|Numeric|`0`|Required: Boolean: 1 = True (break from node down not just direct children)|
  |`pDelim`|String|`&`|Optional: delimiter character for element list (required if pEle parameter is used)|
  ## Full Process Dependencies
[}bedrock.hier.unwind](}bedrock.hier.unwind)  
