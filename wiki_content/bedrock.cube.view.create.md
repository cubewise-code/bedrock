# }bedrock.cube.view.create

Creates a named or temporary cube view with optional dimension filters, suppression settings, and subset management. Supports standard element lists, hierarchy-qualified dimensions, and MDX set expressions.

---

## Use Cases

- Create a filtered view as a data source for copy, export, or calculation processes.
- Generate N-level subsets for all unfiltered dimensions.
- Define views with hierarchy-specific or MDX-based element selections.

---

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `pLogOutput` | Numeric | `0` | Write execution log to server message log (0 = off, 1 = on) |
| `pStrictErrorHandling` | Numeric | `0` | Exit with major error on any error (0 = off, 1 = on) |
| `pCube` | String | *(required)* | Name of the cube for which the view is created |
| `pView` | String | | View name; auto-generated temp name if blank |
| `pFilter` | String | | Dimension filter — see [Filter Syntax](#filter-syntax) |
| `pSuppressZero` | Numeric | `1` | Suppress zero/null cells in the view (1 = yes, 0 = no) |
| `pSuppressConsol` | Numeric | `1` | Suppress consolidated cells (1 = yes, 0 = no) |
| `pSuppressRules` | Numeric | `1` | Suppress rule-derived cells (1 = yes, 0 = no) |
| `pSuppressConsolStrings` | Numeric | `-1` | Suppress consolidated string cells (`-1` = inherit from `pSuppressConsol`) |
| `pIncludeDescendants` | Numeric | `0` | Include all descendants of consolidated elements in filter |
| `pDimDelim` | String | `&` | Delimiter between dimension blocks in `pFilter` |
| `pEleStartDelim` | String | `¦` | Delimiter separating dimension name from elements |
| `pEleDelim` | String | `+` | Delimiter between elements within a dimension block |
| `pTemp` | Numeric | `1` | Temp view/subset handling: `0` = retain, `1` = delete both, `2` = delete view only |
| `pSandBox` | String | | Sandbox name (leave blank for base data) |
| `pSubN` | Numeric | `0` | Create an N-level subset for all dimensions not mentioned in `pFilter` |

---

## Filter Syntax

`pFilter` defines which elements are included in the view for each dimension. Multiple dimension blocks are separated by `pDimDelim` (`&`). Within each block, the dimension name is separated from elements by `pEleStartDelim` (`¦`), and elements are separated by `pEleDelim` (`+`).

### Standard syntax

```
Year¦2024&Version¦Actual+Budget
```

### Hierarchy syntax (PA 2.0+)

A non-default hierarchy can be specified by appending `:HierarchyName` to the dimension name:

```
Year:FiscalYear¦2024&Version¦Actual
```

- If no hierarchy is specified, the default hierarchy (same name as dimension) is used.
- An invalid hierarchy name raises an error (`nErrors + 1`).
- The colon (`:`) is reserved as hierarchy separator and cannot be used as `pDimDelim`, `pEleStartDelim`, or `pEleDelim`.

### MDX syntax

An MDX set expression can be provided instead of an element list. The expression must follow the `MDX:` prefix and be enclosed in `{...}`:

```
Year¦MDX:{[Year].[Year].[2024],[Year].[Year].[2023]}&Version¦Actual
```

- The MDX subset is created by calling `}bedrock.hier.sub.create.bymdx` internally.
- All delimiter characters (`+`, `&`, `¦`) within `{...}` are treated as literals — MDX set operators (e.g. `+`, `*`) and member expressions are not affected.
- Nested braces `{{...}}` are handled correctly by the brace-depth counter.
- An unmatched `{` raises a validation error after parsing.

### Combined: Hierarchy + MDX

```
Year:FiscalYear¦MDX:{[Year].[FiscalYear].Members}&Version¦Actual
```

---

## Subset Behavior

For each dimension mentioned in `pFilter`:

- If a subset with the view name already exists, its elements are replaced (`HierarchySubsetDeleteAllElements`).
- If no subset exists, a new one is created (`HierarchySubsetCreate`).
- For non-default hierarchies, the subset is assigned using `Dim:Hier` notation in `ViewSubsetAssign`.

For dimensions **not** mentioned in `pFilter`:

- If `pSubN = 1`, an N-level subset is created (calls `}bedrock.hier.sub.create`).
- Otherwise, the dimension uses its existing default subset (typically "All").

---

## Parsed Filter

After processing, the resolved filter string is stored in the global string variable `sTargetFilter`. This variable is used by calling processes (e.g. `}bedrock.cube.data.copy.intercube`) to reconstruct the effective filter applied to the target.

---

## Examples

### Minimal — create a temp view for all data

```
pCube = SalesCube
```

### Filtered view with suppression

```
pCube           = SalesCube
pView           = MyView_2024_Actual
pFilter         = Year¦2024&Version¦Actual
pSuppressZero   = 1
pSuppressConsol = 1
pTemp           = 0
```

### N-level view (leaf data only)

```
pCube  = SalesCube
pSubN  = 1
pTemp  = 1
```

### Hierarchy filter

```
pCube    = SalesCube
pFilter  = Year:FiscalYear¦FY2024&Version¦Actual
```

### MDX filter

```
pCube    = SalesCube
pFilter  = Year¦MDX:{[Year].[Year].[2024],[Year].[Year].[2023]}&Version¦Actual
```

### Hierarchy + MDX

```
pCube    = SalesCube
pFilter  = Year:FiscalYear¦MDX:{[Year].[FiscalYear].Members}&Version¦Actual
```

---

## Validation

The process validates:

- `pCube` exists — aborts if not.
- Each dimension name in `pFilter` exists in the cube.
- Each hierarchy name (if specified) exists in its dimension.
- Each element name resolves via `HIERARCHYELEMENTINDEX` — logs a warning for unknown elements.
- Brace balance in MDX expressions — raises error for unmatched `{`.
- The colon (`:`) is not used as a delimiter character.

---

## Related Processes

| Process | Description |
|---|---|
| `}bedrock.cube.data.copy` | Uses view created by this process as source |
| `}bedrock.cube.data.copy.intercube` | Uses view created by this process as source |
| `}bedrock.cube.data.export` | Uses view created by this process as export source |
| `}bedrock.hier.sub.create` | Called for N-level subsets (`pSubN = 1`) |
| `}bedrock.hier.sub.create.bymdx` | Called for MDX-based subsets |

---

## Changelog

| Version | Change |
|---|---|
| 4.1 | Hierarchy syntax (`Dim:HierName`) support in `pFilter`; MDX block syntax (`MDX:{...}`) with brace-depth protection; `HierarchySubset*` functions for subset management; `HIERARCHYELEMENTINDEX` for element validation; colon-as-delimiter conflict check; unmatched-brace error detection; `sParsedFilter` preserves `Dim:Hier` notation |
| 4.0 | Initial Bedrock release |
