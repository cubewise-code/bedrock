## Description
   
 This process will Create a dynamic view from an MDX expression that evaluates to a non-empty set in the specified dimension.  
     
**Use Case:**    Intended for development/prototyping or production.  
1. Create a view to zero out data.  
2. Create a view to use as a source for exporting or copying.  
     
**Note:**     
 Naturally, a valid cube name (`pCube`) is mandatory otherwise the process will abort.  
 If the MDX does not compile or produces an empty set the process will error.  
 `pTemp`: This parameter will control whether to make the view temporary (value 1) or if the    view will be permanently retained (value 0).  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube Name|
  |`pView`|String||Required: View Name|
  |`pMDXExpr`|String||Required: Valid MDX Expression|
  |`pTemp`|Numeric|`1`|Optional: Make View Temporary (1=Temporary)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
