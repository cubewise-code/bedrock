## Description
   
 This process will validate a string `pInputString` based on rules in `pChanges` and change or  eliminate characters to create a global variable sOutputString that can be used in the source TI.  
     
**Note:**     
 - `pInputString`: This is the input string that needs to be validated based on file system    limitations or undesirable 1st characters.  
 - `pUndesirableFileSystem`: These are characters considered undesirable (even forbidden) in    object/element names due to file system limitations of the operation system.  
 - `pUndesirable1st`: These are characters considered undesirable as 1st characters in object/element    names due to TM1 limitations.  
 - `pChanges`: This string defines the rule of how to change undesirable characters. It can be made up    of many definitions delimited by `pDelim` (e.g. `&` which is not considered undesirable    anywhere). Each definition would contain a character considered undesirable and the desired    character separatedby `pSeperator` (e.g. to change a `%` to Percentage and `"` to inches, it would    be `%,Percentage&",inches` if `pDelim` = `&` and `pSeperator` = `,`).  
 - `pReplaceIfNotFound`: This is a catch all for characters listed in `pUndesirableFileSystem` or    `pUndesirable1st` that don't have a rule in `pChanges`.  
 - `pDelim`: This is a character that is used to seperate definitions in `pChanges`.  
 - `pSeperator`: This is a character used to seperate the current and desired character within each    definition in `pChanges`.  
 - `pMode`: This can be used to limit whether the TI looks at `pUndesirableFileSystem` or `pUndesirable1st`    without having to delete the characters in those parameters.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`1`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pInputString`|String||Required: Element name to validate and update if necessary|
  |`pUndesirableFileSystem`|String|`/\|\>"<:?*`|Optional: Undesirable characters for file system (e.g. /\|\>"<:?* )|
  |`pUndesirable1st`|String|`'+-[]@!{}%`|Optional: Undesirable 1st characters (e.g. '+-[]@!{}% )|
  |`pChanges`|String|`\,B Slash&/,F Slash&\|, &-,Minus&+,Plus&>,greater than&<,less than`|Optional: String showing what to change. Replaces with pReplaceIfNotFound if blank.|
  |`pReplaceIfNotFound`|String|`_`|Optional: Replace ndesirable character with this if not specified in pChanges above (blank will delete)|
  |`pDelim`|String|`&`|Required: Delimiter between definitions|
  |`pSeperator`|String|`,`|Required: Seperator between current & desired|
  |`pMode`|Numeric|`3`|Required: 1=Validate for File System only, 2=Validate for 1st only, 3=Validate Fully|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
