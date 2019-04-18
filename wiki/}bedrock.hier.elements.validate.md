## Description
   
 This process will review all elements in selected dimensions (you can specify a single dimension,  
 multiple dimensions or wildcards to match dimensions) and hierarchies and will generate a `csv`  file listing all elements with unusual characters.  
 Control dimensions are ignored.  
     
**Note:**     
 - `pDim`: Specify which dimensions to validate. When specifying a dimension name, wildcards can    be specified by using the `*` and `?` characters. A list of dimensions can also be entered with    a delimiter (e.g. `v*&plan*` will process all dimensions starting with `v` and `plan`). If    * is entered then it ignores anything entered for hierarchy (`pHier`) and processes all dimensions  - `pHier`: Specify which hierarchies to validate. To validate ALL hierachies, enter *.  
   When specifying a hierarchy name, wildcards can be specified by using the    `*` and `?` characters. A list of hierachies can also be entered with a delimiter. If `pHier`    has a value then it does not make sense that `pDim` can be set up as a list or with wildcards.  
 - `pDelim`: The delimiter is used when specifying multiple dimensions or multiple hierachies. The    default delimiter is `&`. Any delimiter can be used by specifying a value for `pDelim`. Choose    a delimiter that won't be used in either the wildcard search strings or dimension names.  
 - `pFirst`:  
   - When set to `1`: all requirements for all characters are validated.  
   - ELSE: ignores stringent requirements for 1st character.  
## Process Parameters
  
|Parameter|Data Type|Default|Prompt Text|
  |---|:-:|:-:|---|
  |`pLogOutput`|Numeric|`0`|Optional: write parameters and action summary to server message log (Boolean True = 1)|
  |`pDim`|String||Optional: Dimension name or list? (accepts wildcards). Will process ALL if = *|
  |`pHier`|String|`*`|Optional: Hierarchy name or list? (accepts wildcards). Will process ALL if = *|
  |`pFirst`|Numeric|`1`|Optional: 0 = Ignore 1st character requirements, 1 = Validate 1st character more stringently than other characters (e.g. for MDX no "+" as 1st character)|
  |`pDelim`|String|`&`|Optional: Delimiter for dimension list (If blank or not passed then "&" will be used as default list delimiter)|
  ## Full Process Dependencies
Process doesn't call any dependencies.  
