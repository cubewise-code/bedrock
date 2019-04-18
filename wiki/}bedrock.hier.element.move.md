## Description
   
 This process will Add or Remove Element from a Consolidation in a Hierarchy.  
     
**Note:**     
 Valid dimension name (`pDim`), consolidated element name (`pTgtConsol`) and element name (`pEle`)  
 otherwise the process will abort. Mode can be either Add to add or Remove to remove the element  from a consolidation.  
     
**:warning:Caution:** Target hierarchy cannot be `Leaves`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension Name|
  |`pHier`|String||Optional: Hierarchy Name|
  |`pEle`|String||Required: Element Name|
  |`pTgtConsol`|String||Required: Target Consolidation|
  |`pMode`|String|`Add`|Required: Add or Remove Element from Hierarchy|
  |`pWeight`|Numeric|`1`|Optional: Element Weight (for Add only)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
