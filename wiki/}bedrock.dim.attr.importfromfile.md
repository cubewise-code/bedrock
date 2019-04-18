## Description
   
 This process will create Attributes of the dimension from a file.  
     
**Use Case:**    Intended for development/prototyping.  
1. Add multiple dimension attributes of different types.  
     
**Note:**     
 The file format is as per the dimension export file applied to an }ElementsAttributes dimension.  
 Naturally, a valid diension name (`pDim`) is mandatory otherwise the process will abort.  
 Also, valid path (`pSrcDir`) & file name (`pSrcFile`) are mandatory otherwise the process will abort.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: dimension name|
  |`pSrcDir`|String||Required: Source Directory|
  |`pSrcFile`|String||Required: Source File Name|
  |`pTitleRows`|Numeric|`1`|Oprional: Number of Title Rows to Skip (default = 1)|
  |`pDelim`|String|`,`|Optional: File Delimiter Character (Default=comma, exactly 3 digits = ASCII code)|
  |`pQuote`|String|`'`|Optional: Quote Character (default=Double Quote)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
