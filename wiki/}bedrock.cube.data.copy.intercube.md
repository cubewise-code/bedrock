## Description
   
 This is the process used to copy data from a source cube to a different target cube.  
     
**Use Case:**    Mainly used in production environments.  
1. This process could be used to populate a Reporting cube.  
2. The process could be used to archive data from one cube to another one for any use.  
     
**Note:**     
 The target cube may have a different number of dimensions as the source cube.  
 Where the target and source cubes share the same dimensions, the process will match the dimensions even if their position in the cube is different.  
 An input element must be specified for each dimension which is in the target but not in the source using the parameter `pMappingToNewDims`.  
 The format of parameter `pMappingToNewDims` using default delimiters & and : is DimInTargetButNotSource1:ElementOfDim & DimInTargetButNotSource2:ElementOfDim.  
 The input element must be an N level unless `pSuppressConsol` is set to 0.  
 For dimensions in the source but not the target, the process will accumulate the values of all n level elements  (or all n level elements specified by the `pFilter` parameter).  
 The `pFilter` parameter contains the dimensons and elements to be used for filtering the source cube.  
 The format of the `pFilter` parameter is as follows, using default delimiters & + : Dim1: Elem1 + Elem2 & Dim2: Elem3 + Elem4.  
 The dimension parameters do not need to be given in the index order of dimensions in the cube.  
 The dimension name is specified as the first member of the delimited string of elements.  
 If consolidations are skipped the N level children of any consolidated filter elements will be used.  
 Spaces are ignored so use them to make your filter more readable.  
 If using the `pFilter`Parallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in  the `pFilter` parameters.  
 When using parallelization via the *RunProcess* function the elements listed in `pFilter`Parallel will be split one_at_a_time  and passed to a recursive call of the process being added to `pFilter`.  
 An example:  
 To copy the 2011 Actual Sales data from the Sales cube to the General Ledger cube,  
 set `pFilter` to Year: 2011 & Version: Actual.  
 Say the General Ledger cube has an Account dimension but the Sales cube doesn't and  the Account for sales is 9999 (an n level element).  
 Set the `pMappingToNewDims` parameter to Account:9999.  
 This will copy all Actual 2011 Sales to Account 9999 in the General Ledger.  
 If only sales for Company X are to be copied, set `pFilter` to Year: 2011 & Version: Actual & Company:X.  
 If sales from other companies are already in the General Ledger,  
 set `pZeroTarget` to 0 to add Company X's data to the existing data.  
 Setting `pZeroTarget` to 1 will clear our data in the target cube for the elements specified in the  `pMappingToNewDims` parameter and the `pFilter` parameter for dimensions that are in the target.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcCube`|String||REQUIRED: Cube data is being copied from|
  |`pFilter`|String||OPTIONAL: Filter on source cube in format Year: 2006 + 2007 & Scenario: Actual + Budget. Blank for whole cube|
  |`pFilterParallel`|String||OPTIONAL: Parallelization Filter: Month:Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter|
  |`pParallelThreads`|Numeric|`2`|Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )|
  |`pTgtCube`|String||REQUIRED: Name of cube to copy the values to|
  |`pMappingToNewDims`|String||REQUIRED IF TARGET HAS DIMS NOT IN SOURCE: DimX:InputElementForDimX & DimY:InputElementForDimY (specify an N level element for each new dim)|
  |`pSuppressConsol`|Numeric|`1`|OPTIONAL: Suppress Consolidations (Skip = 1) Only use 0 for strings|
  |`pSuppressRules`|Numeric|`1`|OPTIONAL: Suppress Rules (Skip = 1)|
  |`pZeroTarget`|Numeric|`1`|OPTIONAL: Zero out Target Element PRIOR to Copy? (Boolean 1=True) Clears combination of pFilter and pMappingToNewDims|
  |`pZeroSource`|Numeric|`0`|OPTIONAL: Zero out Source Element AFTER Copy? (Boolean 1=True). If pFilter is blank the whole source cube is cleared!|
  |`pFactor`|Numeric|`1`|OPTIONAL: Multiply source value by factor (1 keeps the value as is). To modify existing values make the target element the same as the source with pZeroTarget = 0|
  |`pDimDelim`|String|`&`|OPTIONAL. Delimiter for start of Dimension/Element set|
  |`pEleStartDelim`|String|`¦`|OPTIONAL: Delimiter for start of element list|
  |`pEleDelim`|String|`+`|OPTIONAL: Delimiter between elements|
  |`pTemp`|Numeric|`1`|OPTIONAL: Delete temporary view and Subset ( 0 = Retain View and Subsets 1 = Delete View and Subsets 2 = Delete View only )|
  |`pCubeLogging`|Numeric|`0`|OPTIONAL: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)|
  |`pThreadMode`|Numeric|`0`|DO NOT USE: Internal parameter only, please don't use|
  ## Full Process Dependencies
[}bedrock.cube.data.clear](}bedrock.cube.data.clear)  
[}bedrock.cube.view.create](}bedrock.cube.view.create)  
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
