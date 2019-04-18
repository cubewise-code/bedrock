## Description
   
 This process will deletes the log files, csv file, debug files which are 'x' days old.  
     
**Use Case:**    Intended for production.  
1. Process cleans up old files to save space on hard disk.  
     
**Note:**     
 The target directory (`pTgtDir`) will default to setting in TM1 configuration file if left blank.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pTgtDir`|String||Optional: Log file directory. (Blank = from TM1 configuration file)|
  |`pLogDays`|Numeric|`7`|Required: The number of days to retain log Files|
  |`pErrorDays`|Numeric|`21`|Required: The number of day to retain TM1 Error Logs|
  |`pBedrockDays`|Numeric|`7`|Required: The number of days to retain Bedrock Debug Files|
  |`pCSVDays`|Numeric|`7`|Required: The number of days to retain CSV files|
  ## Full Process Dependencies
[}bedrock.server.savedataall](}bedrock.server.savedataall)  
