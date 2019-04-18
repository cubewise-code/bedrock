## Description
   
 This process creates a processing view for the cube and for specified dimensions of the cube.  
     
**Use Case:**    Intended for development/prototyping or in Production environment.  
 1. Create a view with subsets of the same name that are empty.  
     
**Note:**     
 Creates empty subsets and assigns the empty subsets to the view.  
 A subsequent process is required to insert elements into subsets otherwise the views will not contain any data.  
 Naturally, a valid cube name (`pCube`) is mandatory otherwise the process will abort.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`1`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: List of Cubes (Separated by Delimiter, Accepts Wild card)|
  |`pView`|String||Optional: View (will default to pSubset if left blank)|
  |`pSub`|String||Optional: Subset (will default to pView if left blank)|
  |`pDim`|String|`*`|Required: Dimension(s) to create empty processing subsets for (separated by delimiter), * = all|
  |`pDelim`|String|`&`|Optional: List Delimiter|
  |`pSuppressZero`|Numeric|`1`|Optional: Suppress Zeros (Boolean Yes = 1)|
  |`pSuppressConsol`|Numeric|`1`|Optional: Suppress Calcs (Boolean Yes = 1)|
  |`pSuppressRules`|Numeric|`1`|Optional: Suppress Rules (Boolean Yes = 1)|
  |`pTemp`|Numeric|`1`|Optional: Make View Temporary (1=Temporary)|
  |`pSubN`|Numeric|`0`|Optional: Create N level subset for all dims not mentioned in pDim|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
