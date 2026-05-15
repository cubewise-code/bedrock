# }bedrock.cube.data.export

Exports cube data to a delimited ASCII file, with optional filtering, parallelization, and suppression of consolidated, rule-derived, or zero cells.

---

## Use Cases

- Export a cube view or filtered slice to CSV for downstream processing.
- Archive snapshots of cube data to the file system.
- Feed data into external systems or reporting tools.

---

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `pLogoutput` | Numeric | `0` | Write execution log to server message log (0 = off, 1 = on) |
| `pStrictErrorHandling` | Numeric | `0` | Exit with major error on any error (0 = off, 1 = on) |
| `pCube` | String | *(required)* | Name of the cube to export |
| `pView` | String | | View name to export; auto-generated temp view if blank |
| `pFilter` | String | | Dimension filter — see [Filter Syntax](#filter-syntax) |
| `pFilterParallel` | String | | Single dimension used as parallelization slicer — see [Parallelization](#parallelization) |
| `pParallelThreads` | Numeric | `0` | Number of parallel sub-processes (0 = no parallelization) |
| `pDimDelim` | String | `&` | Delimiter between dimension blocks in `pFilter` |
| `pEleStartDelim` | String | `¦` | Delimiter separating dimension name from elements |
| `pEleDelim` | String | `+` | Delimiter between elements within a dimension block |
| `pSuppressZero` | Numeric | `1` | Suppress zero/null cells (1 = skip, 0 = include) |
| `pSuppressConsol` | Numeric | `1` | Suppress consolidated cells (1 = skip, 0 = include) |
| `pSuppressRules` | Numeric | `1` | Suppress rule-derived cells (1 = skip, 0 = include) |
| `pSuppressConsolStrings` | Numeric | `0` | Suppress consolidated string cells (1 = skip) |
| `pIncludeDescendants` | Numeric | `0` | Include all descendants of consolidated elements in filter |
| `pZeroSource` | Numeric | `0` | Zero out source element **after** export (1 = yes) |
| `pCubeLogging` | Numeric | `0` | Transaction logging: `0` = off, `1` = on, `2` = ignore cube setting |
| `pTemp` | Numeric | `1` | Temp view/subset handling: `0` = retain, `1` = delete both, `2` = delete view only |
| `pFilePath` | String | | Directory path for output file (trailing backslash required) |
| `pFileName` | String | | Output file name (without path) |
| `pDelim` | String | `,` | Column delimiter in output file |
| `pDecimalSeparator` | String | `.` | Decimal separator in numeric output (3 digits = ASCII code) |
| `pThousandSeparator` | String | `,` | Thousand separator in numeric output (3 digits = ASCII code) |
| `pQuote` | String | `"` | Quote character for string values |
| `pTitleRecord` | Numeric | `1` | Include header row with dimension names (1 = yes, 0 = no) |
| `pSandbox` | String | | Sandbox name (leave blank for base data) |
| `pSubN` | Numeric | `0` | Create an N-level subset for all dimensions not mentioned in `pFilter` |
| `pCharacterSet` | String | | Character set for output file encoding (blank = server default) |
| `pCubeNameExport` | Numeric | `1` | Include cube name in output file name (1 = yes) |

---

## Filter Syntax

`pFilter` restricts which cells are exported. Multiple dimension blocks are separated by `pDimDelim` (`&`).

### Standard syntax

```
Year¦2024&Version¦Actual
```

### Hierarchy syntax (PA 2.0+)

```
Year:FiscalYear¦2024&Version¦Actual
```

### MDX syntax

```
Year¦MDX:{[Year].[Year].[2024],[Year].[Year].[2023]}&Version¦Actual
```

> `pFilter` is passed as an unmodified string prefix when parallelization splits elements from `pFilterParallel`. MDX blocks and `Dim:Hier` notation in `pFilter` survive the splitting unchanged.

---

## Parallelization

`pFilterParallel` distributes one dimension's elements across parallel sub-processes. Format:

```
Month¦Jan+Feb+Mar
```

The dimension in `pFilterParallel` **must not** also appear in `pFilter`.

> **Hierarchy-aware validation (v4.1+):** The conflict check correctly detects `Dim:Hier¦...` notation in `pFilter`, preventing a false negative when the same dimension is specified with hierarchy syntax.

---

## Output File

The export produces a delimited text file at `pFilePath` + `pFileName`. Each row contains the dimension member values followed by the cell value. If `pTitleRecord = 1`, the first row is a header with dimension names and a `Value` column.

Example output (`pDelim = ,`):

```
Year,Version,Month,Value
2024,Actual,Jan,12345.67
2024,Actual,Feb,9876.54
```

---

## Examples

### Minimal export

```
pCube      = SalesCube
pFilePath  = C:\exports\
pFileName  = sales_actual.csv
```

### Filtered export with header

```
pCube           = SalesCube
pFilter         = Year¦2024&Version¦Actual
pFilePath       = C:\exports\
pFileName       = sales_2024_actual.csv
pTitleRecord    = 1
pSuppressZero   = 1
```

### Parallel export by region

```
pCube              = SalesCube
pFilter            = Year¦2024
pFilterParallel    = Region¦North+South+East+West
pParallelThreads   = 4
pFilePath          = C:\exports\
pFileName          = sales_region.csv
```

### Export with hierarchy filter

```
pCube      = SalesCube
pFilter    = Year:FiscalYear¦2024&Version¦Actual
pFilePath  = C:\exports\
pFileName  = sales_fiscal_2024.csv
```

---

## Related Processes

| Process | Description |
|---|---|
| `}bedrock.cube.data.copy` | Copy data within a cube |
| `}bedrock.cube.data.copy.intercube` | Copy data between two cubes |
| `}bedrock.cube.data.clear` | Clear data in a cube |
| `}bedrock.cube.view.create` | Create a view used as export source |

---

## Changelog

| Version | Change |
|---|---|
| 4.1 | `pFilterParallel` validation extended for `Dim:Hier` notation in `pFilter` — prevents false-negative conflict detection when hierarchy syntax is used |
| 4.0 | Initial Bedrock release |
