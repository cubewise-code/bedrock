## Description
   
 This process localizes cube & dimension names & optionally localizes attributes for any dimension      
**Note:**     
 In no dimension is passed, just cube & dimension names will be localized  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Required: Dimension (Delimited list & wildcards (*) acceptable)|
  |`pDelim`|String|`&`|Required: delimiter character for dimension list. (Defaults to & if blank)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
