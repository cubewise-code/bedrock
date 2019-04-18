## Description
   
 This TI is intended to copy data from one element of a dimension to another in the same cube.  
     
**Use Case:**    Mainly used in production environments.  
1. Typically, this would be used to archive a Budget or Forecast element of a version dimension.  
2. Could also be used to prepopulate a version from a prior year.  
     
**Note:**     
 Naturally, a valid cube name (`pCube`) is required. otherwise the process will abort.  
 Element mapping (`pEleMapping`) is also required, otherwise the process will abort.  
 A filter parameter (`pFilter`) can also be used to filter dimensions that have not been mapped.  
 Source (`pSrcView`) & target (`pTgtView`) views will be assigned temporary names if left blank.  
 All other parameters may be left as is but be sure to use them appropriately when specifying `pEleMapping` & `pFilter` parameters.  
 - Since this TI has a view as a data source, it requires the implicit variables NValue, SValue and Value_is_String.  
 - To edit this TI in Architect a tmp cube with minimum 24 dims is needed as the preview data source or set the data    source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables.  
 - If using the `pFilter`Parallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in    the `pFilter` and `pEleMapping` parameters.  
 - When using parallelization via the *RunProcess* function the elements listed in `pFilter`Parallel will be split one_at_a_time    and passed to a recursive call of the process being added to `pFilter`.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||REQUIRED: Cube|
  |`pSrcView`|String||OPTIONAL: Temporary view name for source|
  |`pTgtView`|String||OPTIONAL: Temporary view name for target|
  |`pFilter`|String||OPTIONAL: Filter Unmapped Dimensions using format: Year: 2006 + 2007 & Scenario: Actual + Budget etc|
  |`pFilterParallel`|String||OPTIONAL: Parallelization Filter: Month:Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter|
  |`pParallelThreads`|Numeric|`2`|Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )|
  |`pEleMapping`|String||REQUIRED: Map source elements to target elements using format Dim1ToCopy:SourceElement->TargetElement & Dim2ToCopy:Source Element->TargetElement etc|
  |`pMappingDelim`|String|`->`|OPTIONAL: Delimiter between source element and target element in pEleMapping|
  |`pDimDelim`|String|`&`|REQUIRED: Delimiter for start of Dimension/Element set|
  |`pEleStartDelim`|String|`¦`|REQUIRED: Delimiter for start of element list|
  |`pEleDelim`|String|`+`|REQUIRED: Delimiter between elements|
  |`pFactor`|Numeric|`1`|OPTIONAL: Multiply source value by factor (1 keeps the value as is). To modify existing values make the target element the same as the source with pZeroTarget = 0|
  |`pSuppressRules`|Numeric|`1`|OPTIONAL: Suppress Rules (Skip = 1)|
  |`pCumulate`|Numeric|`0`|OPTIONAL: 1 = Add source to existing value in target (if zero out target = 0 False). 0 = Replace target with source.|
  |`pZeroTarget`|Numeric|`1`|OPTIONAL: Zero out Target Element PRIOR to Copy? (Boolean 1=True)|
  |`pZeroSource`|Numeric|`0`|OPTIONAL: Zero out Source Element AFTER Copy? (Boolean 1=True)|
  |`pTemp`|Numeric|`1`|OPTIONAL: Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )|
  |`pCubeLogging`|Numeric|`0`|OPTIONAL: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)|
  |`pThreadMode`|Numeric|`0`|DO NOT USE: Internal parameter only, please don't use|
  ## Full Process Dependencies
[}bedrock.cube.data.clear](}bedrock.cube.data.clear)  
[}bedrock.cube.view.create](}bedrock.cube.view.create)  
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
