## Description
   
 This TI is designed to export data in a given cube to a flat file for a given "slice" (any dimension/element combination).  
      
**Use Case:**    Intended for development/prototyping or in Production environment.  
 1. Export data for import into another TM1 model to eliminate possibility of locking.  
 2. Export data for import into ERP system.  
      
**Note:**     
 * Naturally, a valid cube name (`pCube`) is mandatory otherwise the process will abort.  
 * All other parameters are optional, however, the filter (`pFilter`) should be specified to limit the size of the file.  
 * The default output path is the same as the error file path.  
 * As this TI has a view as a data source it requires the implicit variables NValue, SValue and Value_is_String  * To edit this TI in Architect a tmp cube with minimum 24 dims is needed as the preview data source or set the data    source to ASCII and manually edit the TI in notepad after saving to add back the required implicit view variables  * If using the `pFilter`Parallel parameter the **single dimension** used as the "parallelization slicer" cannot appear in    the `pFilter` parameter  * When using parallelization via the *RunProcess* function the elements listed in `pFilter`Parallel will be split one_at_a_time    and passed to a recursive call of the process being added to `pFilter`. Each element name will also be appended to the filename   Warning:  
 As the *RunProcess* function currently has no mechanism to check for the state of the called process if more processes are  released than available CPU cores on the server then this could lead to TM1 consuming all available server resources and a  associated performance issue. Be careful that the number of slicer elements listed in `pFilter`Parallel should not exceed the  number of available cores.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogoutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: cube name|
  |`pView`|String||Optional: Temporary view name|
  |`pFilter`|String||Optional: Filter: Year: 2006 + 2007 & Scenario: Actual + Budget & Organization: North America Operations (Blank=whole cube)|
  |`pFilterParallel`|String||Optional: Parallelization Filter: Month:Q1+Q2+Q3+Q4 (Blank=run single threaded). Single dimension parallel slices. Will be added to filter single element at a time. Dimension must not be part of filter|
  |`pParallelThreads`|Numeric|`1`|Maximum number of threads to run when parallel processing is enabled ( if <2 will execute one thread, but parallel filter is still applied )|
  |`pDimDelim`|String|`&`|Optional: Delimiter between dimensions|
  |`pEleStartDelim`|String|`¦`|Optional: Delimiter for start of element list|
  |`pEleDelim`|String|`+`|Optional: Delimiter between elements|
  |`pSuppressZero`|Numeric|`1`|Optional: Suppress Zero Values (1=Suppress)|
  |`pSuppressConsol`|Numeric|`1`|Optional: Suppress Consolidated Values? (1=Suppress)|
  |`pSuppressRules`|Numeric|`1`|Optional: Suppress Rule Values? (1=Suppress)|
  |`pZeroSource`|Numeric|`0`|Optional: Zero Out view AFTER Copy? (Boolean 1=True)|
  |`pCubeLogging`|Numeric|`0`|Optional: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)|
  |`pTemp`|Numeric|`1`|Optional: Retain temporary view and Subset ( 0 = retain View and Subsets 1 = use temp objects)|
  |`pFilePath`|String||Optional: Export Directory (will default to error file path)|
  |`pFileName`|String||Optional: Export Filename (If Left Blank Defaults to cube_export.csv)|
  |`pDelim`|String|`,`|Optional: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)|
  |`pQuote`|String|`"`|Optional: AsciiOutput quote character (Default=double quote)|
  |`pTitleRecord`|Numeric|`1`|Optional: Include Title Record in Export File? (Boolean 0=false, 1=true, Default=1)|
  ## Full Process Dependencies
[}bedrock.cube.view.create](}bedrock.cube.view.create)  
[}bedrock.hier.sub.create](}bedrock.hier.sub.create)  
[}bedrock.hier.sub.create.bymdx](}bedrock.hier.sub.create.bymdx)  
[}bedrock.hier.sub.exclude](}bedrock.hier.sub.exclude)  
