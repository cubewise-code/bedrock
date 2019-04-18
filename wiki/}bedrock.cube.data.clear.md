## Description
   
 This process could be used extensively by custom TIs in production to clear certain data out of a cube before copying data to that cube.  
     
**Use Case:**    Primarily for production systems.  
1. In production system this is a "workhorse" process called from the prolog of most custom processes prior to querying a data source to refresh cube data.  
2. During development/prototyping can be run manually to clear out a portion of a cube.  
     
**Note:**     
 Wildcards can be used or a list of cubes specified to clear data out of multiple cubes simultaneouly.  
 If no cube (`pCube`) or an invalid cube is specified, the process will abort.  
     
**:warning:Caution:** If no view (`pView`) or filter (`pFilter`) is specified, the entire cube(s) will be cleared out.  
 If a valid view is specified the process will simply zero out that view and ignore any filter (`pFilter`) specified.  
 If no valid view is specified then a temporary view will be built using the filter and its data deleted.  
 The filter can handle specific element references for any number of dimensions and elements.  
 - The `pFilter` parameter contains the dimension and elements to be used for filtering.  
 - The dimension parameters do not need to be given in the index order of dimensions in the cube.  
 - The dimension name is specified as the first member of the delimited string of elements.  
 If using the `pFilter`Parallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in  the `pFilter` parameters.  
 When using parallelization via the *RunProcess* function the elements listed in `pFilter`Parallel will be split one_at_a_time  and passed to a recursive call of the process being added to `pFilter`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Cube Name (wildcard * and/or cube1&cube2 list)|
  |`pView`|String||Optional: View name to be cleared (uses pFilter if pView not specified else clears entire cube)|
  |`pFilter`|String||Optional but ignored if view is specified: Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations|
  |`pFilterParallel`|String||Optional: Parallelization Filter: Month:Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter|
  |`pParallelThreads`|Numeric|`0`|Optional: Ignored if pFilterParallel is empty. Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )|
  |`pDimDelim`|String|`&`|Required: Delimiter for Cubes or Dimensions|
  |`pEleStartDelim`|String|`¦`|Required: Delimiter for start of element list|
  |`pEleDelim`|String|`+`|Required: Delimiter between elements|
  |`pCubeLogging`|Numeric|`0`|Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)|
  |`pTemp`|Numeric|`1`|Optional: Make Views and subsets Temporary (1=Temporary)|
  ## Full Process Dependencies
[}bedrock.cube.view.create](}bedrock.cube.view.create)  
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
