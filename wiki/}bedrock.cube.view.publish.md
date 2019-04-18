## Description
   
 This process converts a private view to a public view for the named client.  
      
**Use Case:**    Intended for development/prototyping or production.  
 1. Make private view public to enable public consumption.  
      
**Note:**     
 * A valid cube name `pCube` is mandatory otherwise the process will abort.  
 * Also, a valid view name `pView` is mandatory otherwise the process will abort.  
 * This process must be run by the user owning the private view; it canot be run by another user.  
 * If the view contains private subsets they must also be made public or the view publish will fail.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube Name|
  |`pView`|String||Required: Private View Name|
  |`pSubPublish`|Numeric|`1`|Optional: Publish Private Subsets? (Boolean 1=Yes)|
  |`pOverwrite`|Numeric|`0`|Optional: Overwrite Existing Named View? (Boolean 1=Yes)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
