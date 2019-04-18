## Description
   
 This process will load a csv text file to the target cube.  
     
**Use Case:**    Intended for development/prototyping or in Production environment.  
1. Import data from another TM1 model.  
2. To eliminate possibility of locking it is sometimes better to export and import when needing to copy data from one cube to another.  
     
**Note:**     
 Naturally, a valid target cube name (`pCube`) is mandatory otherwise the process will abort.  
 The default input path is the same as the error file path if not specified.  
 If the file name is left blank, the process will look for a file called `pCube`_Export.csv.  
 Format:  
 The assumed file format is as per standard CMA export:  
 - v1 specIfies cube name, subsequent fields specify cube address ( individual element names ).  
 - vN specIfies cell data value to load. With provision for files with header rows.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Required: write parameters and action summary to server message log (Boolean True = 1)|
  |`pCube`|String||Required: Target Cube|
  |`pSrcDir`|String||Optional: Source Directory (will default to error log path)|
  |`pSrcFile`|String||Optional: Source File (will default to pCube_Export.csv )|
  |`pDim`|String||Optional: Dimension|
  |`pSrcEle`|String||Optional: Source Element ( Only required if a Dimension is used.)|
  |`pTgtEle`|String||Optional: Target Element (Only required if Dimension is used.)|
  |`pTitleRows`|Numeric|`1`|Required: Number of Title Rows to Skip|
  |`pDelim`|String|`,`|Required: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)|
  |`pQuote`|String|`"`|Required: Quote (Default=double quote)|
  |`pCumulate`|Numeric|`0`|Required: Accumulate Amounts (0 = Overwrite values, 1 = Accumulate values)|
  |`pCubeLogging`|Numeric|`0`|Required: Cube Logging (0 = No transaction logging, 1 = Logging of transactions)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
