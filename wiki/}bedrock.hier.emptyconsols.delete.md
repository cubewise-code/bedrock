## Description
   
 This process will delete all consolidated elements with no children in the target Hierarchy.  
     
**Use Case:**     
 - Service process to clean-up consolidations after dimension changes.  
     
**Note:**     
 Valid target dimension (`pDim`) must be supplied otherwise the process will terminate.  
     
**:warning:Caution:** Target hierarchy (`pHier`) cannot be `Leaves`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Target Dimension|
  |`pHier`|String||Optional: Target Hierarchy (uses default hierarchy if left blank)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
