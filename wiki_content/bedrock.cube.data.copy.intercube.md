# }bedrock.cube.data.copy.intercube

Copies data from one cube to another (or within the same cube), with dimension mapping, element remapping, optional new-dimension injection, and parallelization support.

---

## Use Cases

- Copy data between cubes that share some or all dimensions.
- Map source dimensions to differently-named target dimensions.
- Inject fixed element values for dimensions that exist only in the target cube.
- Consolidate data from multiple source cubes into a target.

---

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `pLogOutput` | Numeric | `0` | Write execution log to server message log (0 = off, 1 = on) |
| `pStrictErrorHandling` | Numeric | `0` | Exit with major error on any error (0 = off, 1 = on) |
| `pSrcCube` | String | *(required)* | Name of the source cube |
| `pTgtCube` | String | *(required)* | Name of the target cube |
| `pFilter` | String | | Dimension filter applied to the **source** cube — see [Filter Syntax](#filter-syntax) |
| `pFilterParallel` | String | | Single dimension used as parallelization slicer — see [Parallelization](#parallelization) |
| `pParallelThreads` | Numeric | `0` | Number of parallel sub-processes (0 = no parallelization) |
| `pMappingToNewDims` | String | | Inject fixed elements for dimensions present only in the target cube — see [New Dimension Mapping](#new-dimension-mapping) |
| `pSuppressConsol` | Numeric | `1` | Suppress consolidated cells (1 = skip) |
| `pSuppressConsolStrings` | Numeric | `0` | Suppress consolidated string cells (1 = skip) |
| `pSuppressRules` | Numeric | `1` | Suppress rule-derived cells (1 = skip) |
| `pSuppressZero` | Numeric | `1` | Suppress zero/null cells (1 = skip) |
| `pZeroTarget` | Numeric | `1` | Zero out target element **before** copy (1 = yes) |
| `pZeroSource` | Numeric | `0` | Zero out source element **after** copy (1 = yes) |
| `pFactor` | Numeric | `1` | Multiplication factor applied to all numeric values |
| `pDimDelim` | String | `&` | Delimiter between dimension blocks in `pFilter` |
| `pEleStartDelim` | String | `¦` | Delimiter separating dimension name from elements |
| `pEleDelim` | String | `+` | Delimiter between elements within a dimension block |
| `pTemp` | Numeric | `1` | Temp view/subset handling: `0` = retain, `1` = delete both, `2` = delete view only |
| `pCubeLogging` | Numeric | `0` | Transaction logging: `0` = off, `1` = on, `2` = ignore cube setting |
| `pSandbox` | String | | Sandbox name (leave blank for base data) |
| `pFile` | Numeric | `0` | Copy via intermediate file: `0` = direct, `1` = file (delete after), `2` = file (retain) |
| `pDelim` | String | `,` | CSV delimiter for `pFile > 0` |
| `pQuote` | String | `"` | Quote character for `pFile > 0` |
| `pDecimalSeparator` | String | `.` | Decimal separator for `pFile > 0` |
| `pThousandSeparator` | String | `,` | Thousand separator for `pFile > 0` |
| `pSubN` | Numeric | `0` | Create an N-level subset for all source dimensions not mentioned in `pFilter` |

> `pThreadMode` and `pThreadControlFile` are internal parameters — do not set manually.

---

## Filter Syntax

`pFilter` restricts data read from the source cube. The same delimiter conventions as `}bedrock.cube.data.copy` apply.

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

> All delimiter characters (`+`, `&`, `¦`) within `{...}` are treated as literals.

### Combined: Hierarchy + MDX

```
Year:FiscalYear¦MDX:{[Year].[FiscalYear].Members}&Version¦Actual
```

> **MDX and remapping:** An MDX block for a source dimension that has no matching target dimension is silently ignored — all elements pass through. This matches the existing behavior for non-overlapping dimensions.

---

## Dimension Mapping

Dimensions are automatically matched by name between source and target cube. Dimensions present in the source but absent from the target are ignored; dimensions present in the target but absent from the source must be handled via `pMappingToNewDims`.

---

## New Dimension Mapping

`pMappingToNewDims` injects a fixed element for each dimension that exists **only in the target cube**. Format:

```
DimName:ElementName
```

Multiple dimensions:

```
Scenario:Actual&Currency:EUR
```

> The colon (`:`) here separates dimension from element — this is distinct from the `Dim:HierName` hierarchy notation in `pFilter`.

---

## Parallelization

`pFilterParallel` distributes one dimension's elements across parallel sub-processes. The dimension specified **must not** also appear in `pFilter`.

> **Hierarchy-aware validation (v4.1+):** The conflict check correctly detects `Dim:Hier¦...` notation in `pFilter`.

---

## Behavior Notes

### Accumulation

This process **always accumulates** — it adds source values to existing target values. There is no `pCumulate` parameter. Use `pZeroTarget = 1` (default) to zero the target before copying if overwrite behavior is desired.

### Value handling (v4.1+)

- **VIEW mode (`pFile = 0`):** Numeric values read via `NValue`; string values via `SValue`. No string conversion or separator dependency.
- **CSV mode (`pFile > 0`):** Values read from the last mapped datasource variable and converted via `StringToNumberEx`.
- Cell type is determined once per data row via `DType` against the **target** cube's last dimension — not repeated per dimension block.
- Numeric writes use `CellIncrementN` — atomic, safe for parallel execution.

### Filter parsing (v4.1+)

The zeichenweise (character-by-character) filter parser has been extended to:

1. Recognize `DimName:HierName` tokens — extracts the bare dimension name for target-cube matching while preserving the full `Dim:Hier` notation in the reconstructed target filter.
2. Handle `MDX:{...}` blocks atomically — all content between `{` and `}` is collected as a single token, bypassing all delimiter checks.
3. Validate unmatched braces after parsing — raises an error if `{` is opened but never closed.
4. Use `HIERARCHYELEMENTINDEX` for element validation when a hierarchy is specified; falls back to the dimension name as default hierarchy when none is given.

---

## Examples

### Minimal — copy SalesCube to ArchiveCube

```
pSrcCube    = SalesCube
pTgtCube    = ArchiveCube
pZeroTarget = 1
```

### With filter and new-dimension injection

```
pSrcCube          = SalesCube
pTgtCube          = ArchiveCube
pFilter           = Year¦2023
pMappingToNewDims = Scenario:Actual
pZeroTarget       = 1
```

### Parallel by region

```
pSrcCube           = SalesCube
pTgtCube           = ArchiveCube
pFilterParallel    = Region¦North+South+East+West
pParallelThreads   = 4
```

### With hierarchy filter

```
pSrcCube    = SalesCube
pTgtCube    = ArchiveCube
pFilter     = Year:FiscalYear¦2024
pZeroTarget = 1
```

---

## Related Processes

| Process | Description |
|---|---|
| `}bedrock.cube.data.copy` | Copy data within the same cube |
| `}bedrock.cube.data.export` | Export cube data to CSV |
| `}bedrock.cube.data.clear` | Clear data in a cube |
| `}bedrock.cube.view.create` | Create a view used as data source |
| `}bedrock.cube.clone` | Clone a cube including data (delegates to this process) |

---

## Changelog

| Version | Change |
|---|---|
| 4.1 | `NValue`/`SValue` for VIEW mode; `CellIncrementN` for atomic writes; `DType` computed once per row against target cube; `CubeDimensionCountGet` replaces TabDim while-loop; filter parser extended for `Dim:Hier` notation, MDX block handling, `HIERARCHYELEMENTINDEX` element validation, and unmatched-brace error detection; `pFilterParallel` validation extended for `Dim:Hier` notation |
| 4.0 | Initial Bedrock release |
