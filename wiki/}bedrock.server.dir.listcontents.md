## Description
   
 This process will list all files and processes in the data directory as text file output in the data directory itself.  
     
**Use Case:**    Intended for production.  
1. Obtain a listing of files in any folder.  
     
**Note:**     
 The TI 1st creates a batch file that will list all the different type of objects seperately and then executes it.  
 In some cases the path to the batch file (in the data directory) must be fully qualified.  
 The batch file is deleted in Epilog.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pSrcDir`|String||Optional: Data Directory (Leave Blank to use TM1 Settings)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
