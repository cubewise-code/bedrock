# }bedrock.hier.clone

## Overview

This process clones a source dimension hierarchy into a target dimension hierarchy. It replicates the element structure, consolidation relationships, sort order, and optionally element attributes (including localized attributes).

**Bedrock Version:** 4.0+  
**GitHub:** [cubewise-code/bedrock](https://github.com/cubewise-code/bedrock)

---

## Use Cases

- Create a duplicate of an existing hierarchy for testing or development purposes.
- Use an existing dimension as a **structural skeleton** for a new, more detailed dimension by converting all leaf (N) elements to consolidation (C) elements (`pIfNthanC = 1`).
- Clone a hierarchy into a new dimension while optionally replicating or selectively copying element attributes.
- Clone only a **filtered subset of elements** from a large hierarchy using a named subset or an MDX expression (`pSrcFilter`).

---

## Parameters

| Parameter             | Type    | Required | Default | Description |
|-----------------------|---------|----------|---------|-------------|
| `pLogOutput`          | Numeric | Optional | `0`     | Write parameters and action summary to the server message log. `1` = enabled. |
| `pStrictErrorHandling`| Numeric | Optional | `0`     | On any error, exit with major error status via `ProcessQuit`. `1` = enabled. |
| `pSrcDim`             | String  | Required | `""`    | Source dimension name. May be supplied as `Dim:Hier` – the process will split it automatically. |
| `pSrcHier`            | String  | Required | `""`    | Source hierarchy name. Defaults to the dimension name if left empty. |
| `pTgtDim`             | String  | Required | `""`    | Target dimension name. May be the same as the source. If the dimension does not exist it will be created. |
| `pTgtHier`            | String  | Optional | `""`    | Target hierarchy name. Defaults to `<SrcHier>_Clone` when source and target dimension are the same. |
| `pAttr`               | Numeric | Optional | `0`     | Attribute handling. `0` = no attributes; `1` = create missing attributes and copy all values; `2` = copy values only for attributes that already exist on both source and target. |
| `pUnwind`             | Numeric | Required | `0`     | How to handle an existing target hierarchy. `0` = delete all elements; `1` = unwind existing consolidations; `2` = leave existing structure untouched. |
| `pIfNthanC`           | Numeric | Optional | `0`     | If `1`, all Numeric (N) elements from the source are inserted as Consolidated (C) elements in the target. String (S) elements are always kept as-is. |
| `pSrcFilter`          | String  | Optional | `""`    | Element filter. `Subset:<name>` uses an existing named subset; `MDX:<expression>` creates a temporary static subset from the MDX expression. Empty = clone all elements. |

---

## Behaviour

### Source & Target Resolution

- If `pSrcDim` is supplied in `Dim:Hier` format and `pSrcHier` is empty, the process automatically splits the value into dimension and hierarchy.
- The same auto-split logic applies to `pTgtDim`.
- If the target dimension does not exist it is created automatically. In this case the process first clones into the same-named hierarchy of the new dimension (to allow attributes to be processed in the Data tab), then calls itself recursively to create the requested alternate hierarchy.

### Element Insertion (`pIfNthanC`)

By default, element types are copied 1:1 from source to target.  
When `pIfNthanC = 1`:

- All **N-elements** (Numeric/Leaf) are inserted as **C-elements** (Consolidated) in the target hierarchy.
- **S-elements** (String) are always inserted as S-elements regardless of `pIfNthanC`.

This is useful when cloning a dimension that will serve as the structural basis for a new, more detailed dimension: all elements are immediately available as consolidations that can receive child members without needing a separate conversion step.

### Consolidation Relationships (Metadata tab)

The process iterates over all C-elements in the source hierarchy and replicates their child–weight relationships to the target hierarchy via `HierarchyElementComponentAdd`.

### Sort Order

The sort order (`SORTELEMENTSTYPE`, `SORTELEMENTSSENSE`, `SORTCOMPONENTSTYPE`, `SORTCOMPONENTSSENSE`) is read from the source hierarchy's `}DimensionProperties` and applied to the target hierarchy in both the Prolog and Epilog.

### Attribute Replication (`pAttr`)

| `pAttr` | Behaviour |
|---------|-----------|
| `0`     | No attributes are copied. |
| `1`     | Missing attributes are created on the target dimension. All attribute values (String, Numeric, Alias) are copied from source to target elements. |
| `2`     | No new attributes are created. Only attribute values for attributes that already exist on **both** source and target dimension are copied. Useful when the target has a curated attribute schema that must not be altered. |

Localized attributes (`}LocalizedElementAttributes_*`) are replicated when the source localization cube exists.

### Element Filter (`pSrcFilter`)

When `pSrcFilter` is supplied, only the elements resolved by the filter are cloned. Both the element insertion loop (Prolog) and the consolidation relationship loop (Metadata) are restricted to the working subset.

| Prefix | Behaviour |
|--------|-----------|
| *(empty)* | No filter – full hierarchy is cloned (`ALL` subset). |
| `Subset:<name>` | Uses the named subset on `pSrcDim:pSrcHier`. The subset must exist; an error is raised otherwise. |
| `MDX:<expression>` | Calls `}bedrock.hier.sub.create.bymdx` to create a temporary **public static** subset from the MDX expression. The subset is destroyed at the end of the Epilog. |

**Partial hierarchy behaviour (Strategy A — strict):**  
Consolidation relationships are only written when the child element is also present in the working subset. Parent elements whose children are entirely outside the filter are inserted without children.

> If the MDX expression resolves to zero elements, the target hierarchy is created/cleared but left empty. No error is raised.

### Unwind behaviour (`pUnwind`)

| `pUnwind` | Behaviour |
|-----------|-----------|
| `0`       | All elements in the target hierarchy are deleted before cloning (`HierarchyDeleteAllElements`). |
| `1`       | Existing consolidations are unwound by calling `}bedrock.hier.unwind` before cloning. |
| `2`       | The existing target hierarchy structure is left untouched; only missing elements/relationships are added. |

> **Note:** If the target dimension or hierarchy does not yet exist, `pUnwind` is automatically set to `2` internally (nothing to unwind).

---

## Notes & Cautions

- **Target hierarchy cannot be `Leaves`** – the process will abort with an error if `pTgtHier` resolves to `Leaves`.
- If source and target dimension are the same and no `pTgtHier` is provided, the target hierarchy is automatically named `<SrcHier>_Clone`.
- When `pIfNthanC = 1`, the Metadata tab still processes consolidation relationships based on the **source** element type. Only C-elements in the source have their children replicated. Elements that were N in the source but inserted as C in the target will have no children initially – they are ready to receive children as part of subsequent detailing work.
- `pAttr = 2` does not raise an error if no matching attributes are found; it simply copies nothing.
- `pSrcFilter` requires `}bedrock.hier.sub.create.bymdx` to be present on the server when using the `MDX:` prefix.
- The temporary subset created for `MDX:` filters uses the existing `cTempSub` constant (process name + timestamp + random int) and is automatically destroyed in the Epilog. It is safe under concurrent execution.
- An unrecognised `pSrcFilter` prefix (i.e. neither `Subset:` nor `MDX:`) causes an immediate abort.

---

## Example Call

```
# Clone hierarchy and convert all N-elements to C-elements
ExecuteProcess( '}bedrock.hier.clone',
    'pLogOutput', 1,
    'pStrictErrorHandling', 0,
    'pSrcDim', 'Product',
    'pSrcHier', 'Product',
    'pTgtDim', 'Product_Detail',
    'pTgtHier', '',
    'pAttr', 2,
    'pUnwind', 0,
    'pIfNthanC', 1
);
```

This call:
1. Clones the `Product` hierarchy into a new `Product_Detail` dimension.
2. Converts all N-elements to C-elements so the new dimension can immediately receive child members.
3. Copies attribute values only for attributes that already exist on the target (`pAttr = 2`).

### Filter by named subset

```
ExecuteProcess( '}bedrock.hier.clone',
    'pLogOutput', 1,
    'pStrictErrorHandling', 0,
    'pSrcDim', 'Product',
    'pSrcHier', 'Product',
    'pTgtDim', 'Product_Region_A',
    'pTgtHier', '',
    'pAttr', 1,
    'pUnwind', 0,
    'pIfNthanC', 0,
    'pSrcFilter', 'Subset:Region_A_Products'
);
```

Clones only the elements contained in the named subset `Region_A_Products`.

### Filter by MDX expression

```
ExecuteProcess( '}bedrock.hier.clone',
    'pLogOutput', 1,
    'pStrictErrorHandling', 1,
    'pSrcDim', 'Product',
    'pSrcHier', 'Product',
    'pTgtDim', 'Product_HW',
    'pTgtHier', '',
    'pAttr', 1,
    'pUnwind', 0,
    'pIfNthanC', 1,
    'pSrcFilter', 'MDX:{[Product].[Product].[Hardware].Children}'
);
```

Clones only the direct children of `Hardware`, inserts them as C-elements, and cleans up the temporary subset automatically.

---

## Related Processes

| Process | Description |
|---------|-------------|
| [`}bedrock.hier.unwind`](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.hier.unwind) | Unwinds consolidation relationships in a hierarchy |
| [`}bedrock.dim.clone`](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.dim.clone)   | Clones an entire dimension including all hierarchies |
| [`}bedrock.hier.create`](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.hier.create) | Creates a new hierarchy in an existing dimension |
| [`}bedrock.hier.sub.create.bymdx`](https://github.com/cubewise-code/bedrock/wiki/%7Dbedrock.hier.sub.create.bymdx) | Creates a named subset from an MDX expression (used internally by `pSrcFilter`) |
