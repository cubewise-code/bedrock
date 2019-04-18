## Description
   
 This process deletes a view and all subsets of the same name.  
     
**Use Case:**     
 1. In production environment used in Epilog to remove view & subsets used for processing.  
 2. In development/prototyping to manually clean up views & subsets.  
     
**Note:**     
 * Lists and wildcards are not supported in this process  * A valid cube name `pCube` is mandatory otherwise the process will abort.  
 * A valid view name `pView` is mandatory otherwise the process will abort.  
 * The matching assumption is based on **name**. Subsets of the same name as the view will be deleted (whether they were assigned to the view or not).  
 * `pMode` 0 = Delete views and **indirectly** delete subsets via bedrock process call. If a subset cannot be deleted the process will continue and exit with minor error status.  
 * `pMode` 1 = Delete views and **directly** delete subsets via SubsetDestroy function. If a subset cannot be deleted the process will abort with major error status.  
 * `pMode` 2 = Delete views only and leave subsets as is.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube Name|
  |`pView`|String||Required: View Name|
  |`pSub`|String||Optional: Subset Name (will default to pView if left blank)|
  |`pMode`|Numeric|`1`|Required: Delete temporary view and Subset (0 = Delete View and Subsets indirectly 1 = Delete View and Subsets directly 2 = Delete View only )|
  ## Full Process Dependencies
[}bedrock.hier.sub.delete](}bedrock.hier.sub.delete)  
