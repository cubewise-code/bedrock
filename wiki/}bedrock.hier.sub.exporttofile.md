## Description
   
 This process will Export a subset in a Hierarchy of a Dimension to a file. Custom record delimiter  (specified by a character or its ASCII code) can be used.  
 __Format of the file:__  - 1st line: File metadata contains summary information about the dimension, hierarchy, subset    name, number of elements and date/time when file was generated.  
 - 2nd line and forth: Elements export data.  
     
**Note:**     
 Valid dimension name (`pDim`), subset name (`pSub`), inclusion of header (`pTitleRecord`)  
 are mandatory otherwise the process will abort. Target folder (`pTgtDir`) must exist.  
 If needed, custom delimiter might be used by specifying parameter `pDelim` value as either exactly one  character or as a 3-digit (decimal) ASCII code. For example to use TAB as a delimiter, use 009.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension name|
  |`pHier`|String||Optional: Hierarchy name (default if blank = same named hierarchy)|
  |`pSub`|String||Required: Subset name|
  |`pTgtDir`|String||Required: Target Directory Path|
  |`pTgtFile`|String||Optional: Target File Name (Default Extension .csv)|
  |`pTitleRecord`|Numeric|`1`|Optional: Boolean: 1 = Yes include header row|
  |`pDelim`|String|`,`|Optional: AsciiOutput delimiter character (Default=comma, exactly 3 digits = ASCII code)|
  |`pQuote`|String|`"`|Optional: AsciiOutput quote character (Default=double quote)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
