# }bedrock.cube.data.copy

Copies data within a cube from one element (or set of elements) to another, with optional element remapping, filtering, and parallelization.

---

## Use Cases

- Archive a Budget or Forecast version to a prior-year element.
- Pre-populate a planning version from a prior cycle.
- Selectively copy numeric and string cell values across dimension members.

---

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `pLogOutput` | Numeric | `0` | Write execution log to server message log (0 = off, 1 = on) |
| `pStrictErrorHandling` | Numeric | `0` | Exit with major error on any error (0 = off, 1 = on) |
| `pCube` | String | *(required)* | Name of the source and target cube |
| `pSrcView` | String | | Source view name; auto-generated temp view if blank |
| `pTgtView` | String | | Target view name; auto-generated temp view if blank |
| `pFilter` | String | | Dimension filter — see [Filter Syntax](#filter-syntax) |
| `pFilterParallel` | String | | Single dimension used as parallelization slicer — see [Parallelization](#parallelization) |
| `pParallelThreads` | Numeric | `0` | Number of parallel sub-processes (0 = no parallelization) |
| `pEleMapping` | String | *(required)* | Element mapping — see [Element Mapping](#element-mapping) |
| `pMappingDelim` | String | `->` | Delimiter between source and target element in `pEleMapping` |
| `pDimDelim` | String | `&` | Delimiter between dimension blocks in `pFilter` and `pEleMapping` |
| `pEleStartDelim` | String | `¦` | Delimiter separating dimension name from elements |
| `pEleDelim` | String | `+` | Delimiter between elements within a dimension block |
| `pFactor` | Numeric | `1` | Multiplication factor applied to all numeric values during copy |
| `pStringPrefix` | String | | Prefix prepended to string cell values |
| `pStringSuffix` | String | | Suffix appended to string cell values |
| `pSuppressConsol` | Numeric | `1` | Suppress consolidated cells (1 = skip, 0 = include) |
| `pSuppressConsolStrings` | Numeric | `0` | Suppress consolidated string cells (1 = skip) |
| `pSuppressRules` | Numeric | `1` | Suppress rule-derived cells (1 = skip, 0 = include) |
| `pSuppressZero` | Numeric | `1` | Suppress zero/null cells (1 = skip, 0 = include) |
| `pIncludeDescendants` | Numeric | `0` | Include all descendants when element mapping hits a consolidated element |
| `pCumulate` | Numeric | `0` | `1` = add source to existing target value; `0` = overwrite target |
| `pZeroTarget` | Numeric | `1` | Zero out target element **before** copy (1 = yes) |
| `pZeroSource` | Numeric | `0` | Zero out source element **after** copy (1 = yes) |
| `pTemp` | Numeric | `1` | Temp view/subset handling: `0` = retain, `1` = delete both, `2` = delete view only |
| `pCubeLogging` | Numeric | `0` | Transaction logging: `0` = off, `1` = on, `2` = ignore cube setting |
| `pSandbox` | String | | Sandbox name (leave blank for base data) |
| `pFile` | Numeric | `0` | Copy via intermediate file: `0` = direct, `1` = file (delete after), `2` = file (retain) |
| `pDelim` | String | `,` | CSV delimiter for `pFile > 0` |
| `pQuote` | String | `"` | Quote character for `pFile > 0` |
| `pDecimalSeparator` | String | `.` | Decimal separator for `pFile > 0` (3 digits = ASCII code) |
| `pThousandSeparator` | String | `,` | Thousand separator for `pFile > 0` (3 digits = ASCII code) |
| `pSubN` | Numeric | `0` | Create an N-level subset for all dimensions not mentioned in `pFilter` |
| `pMaxWaitSeconds` | Numeric | `1800` | Maximum wait time (seconds) for parallel sub-processes |

> `pThreadMode` and `pThreadControlFile` are internal parameters — do not set manually.

---

## Filter Syntax

`pFilter` restricts the data copied from the source view. Multiple dimension blocks are separated by `pDimDelim` (`&`). Within each block, the dimension name is separated from the element list by `pEleStartDelim` (`¦`), and elements are separated by `pEleDelim` (`+`).

### Standard syntax

```
Year¦2024&Version¦Actual+Budget
```

### Hierarchy syntax (PA 2.0+)

Dimension and hierarchy can be specified with a colon separator:

```
Year:FiscalYear¦2024&Version¦Actual
```

If no hierarchy is specified, the default hierarchy (same name as dimension) is used.

### MDX syntax

An MDX set expression can be used instead of a list of elements. The MDX block must begin with `MDX:{` and end with `}`:

```
Year¦MDX:{[Year].[Year].[2024],[Year].[Year].[2023]}&Version¦Actual
```

> **Note:** All delimiter characters (`+`, `&`, `¦`) within `{...}` are treated as literals — MDX set operators are not affected.

### Combined: Hierarchy + MDX

```
Year:FiscalYear¦MDX:{[Year].[FiscalYear].Members}&Version¦Actual
```

---

## Element Mapping

`pEleMapping` defines which source element maps to which target element for one or more dimensions. Format:

```
DimName¦SourceElem->TargetElem
```

Multiple dimensions:

```
Version¦Actual->Budget&Year¦2023->2024
```

> `pEleMapping` is required — the process aborts without it.

---

## Parallelization

`pFilterParallel` specifies a **single dimension** whose elements are distributed across parallel sub-processes. Format is identical to a single-dimension `pFilter` block:

```
Month¦Jan+Feb+Mar
```

Each element is passed as a separate recursive call. The dimension specified in `pFilterParallel` **must not** also appear in `pFilter`.

> **Hierarchy-aware validation (v4.1+):** The conflict check correctly detects `Dim:Hier¦...` notation in `pFilter`, preventing silent double-filtering.

---

## Behavior Notes

### Value handling (v4.1+)

- **VIEW mode (`pFile = 0`):** Numeric values are read via the implicit `NValue` variable — no string conversion, no separator dependency. String values are read via `SValue`.
- **CSV mode (`pFile > 0`):** Values are read from the last datasource variable and converted via `StringToNumberEx` using `pDecimalSeparator`/`pThousandSeparator`.
- Cell type is determined once per data row via `DType` — not repeated per dimension block.

### Cumulate

- `pCumulate = 1` with numeric cells: uses atomic `CellIncrementN` — safe for parallel execution.
- `pCumulate = 1` with string cells: prepends existing cell value with a space separator.

### Special cubes (2-dimensional only)

- `}ElementSecurity_*` cubes: uses `ElementSecurityPut`.
- Attribute cubes (`AA`/`AS`/`AN`): uses `AttrPutS`/`AttrPutN`.

---

## Examples

### Minimal — copy Actual to Budget within same cube

```
pCube          = SalesCube
pEleMapping    = Version¦Actual->Budget
pZeroTarget    = 1
```

### With filter and factor

```
pCube          = SalesCube
pFilter        = Year¦2023
pEleMapping    = Version¦Actual->Budget
pFactor        = -1
pZeroTarget    = 1
```

### Parallel by month

```
pCube              = SalesCube
pEleMapping        = Version¦Actual->Budget
pFilterParallel    = Month¦Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov+Dec
pParallelThreads   = 4
```

### Via intermediate file (reduces locking)

```
pCube          = SalesCube
pEleMapping    = Version¦Actual->Budget
pFile          = 1
```

---

## Related Processes

| Process | Description |
|---|---|
| `}bedrock.cube.data.copy.intercube` | Copy data between two different cubes |
| `}bedrock.cube.data.export` | Export cube data to CSV |
| `}bedrock.cube.data.clear` | Clear data in a cube |
| `}bedrock.cube.view.create` | Create a view used as data source |
| `}bedrock.cube.clone` | Clone a cube including data (delegates to intercube) |

---

## Changelog

| Version | Change |
|---|---|
| 4.1 | `NValue`/`SValue` for VIEW mode — eliminates separator dependency; `CellIncrementN` for atomic cumulation; `DType` computed once per row; `CubeDimensionCountGet` replaces TabDim while-loop; `pFilterParallel` validation extended for `Dim:Hier` notation |
| 4.0 | Initial Bedrock release |
