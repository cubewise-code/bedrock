# }bedrock.cube.data.clear

Clears (zeros out) data in a cube, optionally restricted to a filtered view or specific slice. Supports optional parallelization across one dimension.

---

## Use Cases

- Zero out a full cube or a filtered slice before a reload.
- Clear data for a specific version, period, or entity without touching other data.
- Parallel clear across multiple dimension members for large cubes.

---

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `pLogOutput` | Numeric | `0` | Write execution log to server message log (0 = off, 1 = on) |
| `pStrictErrorHandling` | Numeric | `0` | Exit with major error on any error (0 = off, 1 = on) |
| `pCube` | String | *(required)* | Name of the cube to clear; supports wildcard `*` to match multiple cubes |
| `pView` | String | | View name to clear; auto-generated temp view if blank |
| `pFilter` | String | | Dimension filter — see [Filter Syntax](#filter-syntax) |
| `pFilterParallel` | String | | Single dimension used as parallelization slicer — see [Parallelization](#parallelization) |
| `pParallelThreads` | Numeric | `0` | Number of parallel sub-processes (0 = no parallelization) |
| `pDimDelim` | String | `&` | Delimiter between dimension blocks in `pFilter` |
| `pEleStartDelim` | String | `¦` | Delimiter separating dimension name from elements |
| `pEleDelim` | String | `+` | Delimiter between elements within a dimension block |
| `pSuppressConsolStrings` | Numeric | `0` | Suppress consolidated string cells (1 = skip) |
| `pCubeLogging` | Numeric | `0` | Transaction logging: `0` = off, `1` = on, `2` = ignore cube setting |
| `pTemp` | Numeric | `1` | Temp view/subset handling: `0` = retain, `1` = delete both, `2` = delete view only |
| `pSandbox` | String | | Sandbox name (leave blank for base data) |
| `pSubN` | Numeric | `0` | Create an N-level subset for all dimensions not mentioned in `pFilter` |

---

## Filter Syntax

`pFilter` restricts which cells are cleared. Multiple dimension blocks are separated by `pDimDelim` (`&`). The filter string is passed directly to `}bedrock.cube.view.create`.

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

---

## Parallelization

`pFilterParallel` distributes one dimension's elements across parallel sub-processes. Format:

```
Month¦Jan+Feb+Mar
```

The dimension in `pFilterParallel` **must not** also appear in `pFilter`.

> **Hierarchy-aware validation (v4.1+):** The conflict check correctly detects `Dim:Hier¦...` notation in `pFilter`, preventing a false negative when the same dimension is specified with hierarchy syntax.

---

## Examples

### Clear entire cube

```
pCube = SalesCube
```

### Clear a filtered slice

```
pCube   = SalesCube
pFilter = Year¦2024&Version¦Budget
```

### Parallel clear by region

```
pCube              = SalesCube
pFilter            = Year¦2024
pFilterParallel    = Region¦North+South+East+West
pParallelThreads   = 4
```

### Clear with hierarchy filter

```
pCube   = SalesCube
pFilter = Year:FiscalYear¦2024&Version¦Actual
```

### Clear all cubes matching a pattern

```
pCube = Sales*
```

---

## Related Processes

| Process | Description |
|---|---|
| `}bedrock.cube.data.copy` | Copy data within a cube |
| `}bedrock.cube.data.copy.intercube` | Copy data between two cubes |
| `}bedrock.cube.data.export` | Export cube data to CSV |
| `}bedrock.cube.view.create` | Create a view (used internally by this process) |

---

## Changelog

| Version | Change |
|---|---|
| 4.1 | `pFilterParallel` validation extended for `Dim:Hier` notation in `pFilter` — prevents false-negative conflict detection when hierarchy syntax is used |
| 4.0 | Initial Bedrock release |
