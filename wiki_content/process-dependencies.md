# Bedrock Process Dependencies

Transitive call graph for all `}bedrock.*` processes in the Upload folder.
Each entry lists **all** processes that are called, directly or via intermediate processes.

> `If( 1 = 0 )` dead-code blocks and `#` comment lines are excluded from all call detection.

---

## Overview

**Chore**

| Process | Total dependencies |
|---|---|
| [`}bedrock.chore.execution.check`](#bedrockchoreexecutioncheck) | — |

**Cube**

| Process | Total dependencies |
|---|---|
| [`}bedrock.cube.clone`](#bedrockcubeclone) | 8 |
| [`}bedrock.cube.create`](#bedrockcubecreate) | — |
| [`}bedrock.cube.data.clear`](#bedrockcubedataclear) | 4 |
| [`}bedrock.cube.data.copy`](#bedrockcubedatacopy) | 6 |
| [`}bedrock.cube.data.copy.intercube`](#bedrockcubedatacopyintercube) | 6 |
| [`}bedrock.cube.data.export`](#bedrockcubedataexport) | 4 |
| [`}bedrock.cube.data.hold`](#bedrockcubedatahold) | 9 |
| [`}bedrock.cube.data.import`](#bedrockcubedataimport) | 5 |
| [`}bedrock.cube.data.save`](#bedrockcubedatasave) | — |
| [`}bedrock.cube.delete`](#bedrockcubedelete) | — |
| [`}bedrock.cube.dimension.add`](#bedrockcubedimensionadd) | 11 |
| [`}bedrock.cube.dimension.delete`](#bedrockcubedimensiondelete) | 11 |
| [`}bedrock.cube.dimension.replace`](#bedrockcubedimensionreplace) | 11 |
| [`}bedrock.cube.rule.manage`](#bedrockcuberulemanage) | 1 |
| [`}bedrock.cube.rule.processfeeders`](#bedrockcuberuleprocessfeeders) | — |
| [`}bedrock.cube.view.create`](#bedrockcubeviewcreate) | 3 |
| [`}bedrock.cube.view.create.bymdx`](#bedrockcubeviewcreatebymdx) | — |
| [`}bedrock.cube.view.delete`](#bedrockcubeviewdelete) | — |
| [`}bedrock.cube.view.publish`](#bedrockcubeviewpublish) | — |
| [`}bedrock.cube.viewandsubsets.create`](#bedrockcubeviewandsubsetscreate) | — |
| [`}bedrock.cube.viewandsubsets.delete`](#bedrockcubeviewandsubsetsdelete) | 1 |

**Dimension**

| Process | Total dependencies |
|---|---|
| [`}bedrock.dim.attr.create`](#bedrockdimattrcreate) | — |
| [`}bedrock.dim.attr.delete`](#bedrockdimattrdelete) | — |
| [`}bedrock.dim.attr.importfromfile`](#bedrockdimattrimportfromfile) | — |
| [`}bedrock.dim.attr.swapalias`](#bedrockdimattrswapalias) | — |
| [`}bedrock.dim.clone`](#bedrockdimclone) | 3 |
| [`}bedrock.dim.delete`](#bedrockdimdelete) | — |

**Hierarchy**

| Process | Total dependencies |
|---|---|
| [`}bedrock.hier.clone`](#bedrockhierclone) | 1 |
| [`}bedrock.hier.consol.delete`](#bedrockhierconsoldelete) | 1 |
| [`}bedrock.hier.consol.flat.create`](#bedrockhierconsolflatcreate) | 1 |
| [`}bedrock.hier.create`](#bedrockhiercreate) | — |
| [`}bedrock.hier.create.fromattribute`](#bedrockhiercreatefromattribute) | 1 |
| [`}bedrock.hier.create.fromrollup`](#bedrockhiercreatefromrollup) | 10 |
| [`}bedrock.hier.create.fromrollup.aliasswap`](#bedrockhiercreatefromrollupaliasswap) | 14 |
| [`}bedrock.hier.create.fromsubset`](#bedrockhiercreatefromsubset) | 8 |
| [`}bedrock.hier.delete`](#bedrockhierdelete) | — |
| [`}bedrock.hier.element.create`](#bedrockhierelementcreate) | — |
| [`}bedrock.hier.element.delete`](#bedrockhierelementdelete) | — |
| [`}bedrock.hier.element.move`](#bedrockhierelementmove) | — |
| [`}bedrock.hier.elements.validate`](#bedrockhierelementsvalidate) | — |
| [`}bedrock.hier.emptyconsols.delete`](#bedrockhieremptyconsolsdelete) | — |
| [`}bedrock.hier.export`](#bedrockhierexport) | 5 |
| [`}bedrock.hier.export.script`](#bedrockhierexportscript) | — |
| [`}bedrock.hier.import`](#bedrockhierimport) | 8 |
| [`}bedrock.hier.leaves.orphan.check`](#bedrockhierleavesorphancheck) | — |
| [`}bedrock.hier.leaves.sync`](#bedrockhierleavessync) | — |
| [`}bedrock.hier.sub.clone`](#bedrockhiersubclone) | — |
| [`}bedrock.hier.sub.create`](#bedrockhiersubcreate) | 2 |
| [`}bedrock.hier.sub.create.all`](#bedrockhiersubcreateall) | 3 |
| [`}bedrock.hier.sub.create.attribute.all`](#bedrockhiersubcreateattributeall) | 3 |
| [`}bedrock.hier.sub.create.attribute.leaf`](#bedrockhiersubcreateattributeleaf) | 3 |
| [`}bedrock.hier.sub.create.byelement`](#bedrockhiersubcreatebyelement) | 3 |
| [`}bedrock.hier.sub.create.bylevel`](#bedrockhiersubcreatebylevel) | — |
| [`}bedrock.hier.sub.create.bymdx`](#bedrockhiersubcreatebymdx) | — |
| [`}bedrock.hier.sub.create.consolidation.all`](#bedrockhiersubcreateconsolidationall) | 3 |
| [`}bedrock.hier.sub.create.consolidation.leaf`](#bedrockhiersubcreateconsolidationleaf) | 3 |
| [`}bedrock.hier.sub.create.leaf`](#bedrockhiersubcreateleaf) | 3 |
| [`}bedrock.hier.sub.create.orphans`](#bedrockhiersubcreateorphans) | — |
| [`}bedrock.hier.sub.create.toplevelhierarchy`](#bedrockhiersubcreatetoplevelhierarchy) | — |
| [`}bedrock.hier.sub.delete`](#bedrockhiersubdelete) | — |
| [`}bedrock.hier.sub.exclude`](#bedrockhiersubexclude) | 1 |
| [`}bedrock.hier.sub.exporttofile`](#bedrockhiersubexporttofile) | — |
| [`}bedrock.hier.sub.publish`](#bedrockhiersubpublish) | — |
| [`}bedrock.hier.unwind`](#bedrockhierunwind) | — |

**Process**

| Process | Total dependencies |
|---|---|
| [`}bedrock.process.template`](#bedrockprocesstemplate) | 5 |

**Security**

| Process | Total dependencies |
|---|---|
| [`}bedrock.security.client.clone`](#bedrocksecurityclientclone) | 1 |
| [`}bedrock.security.client.create`](#bedrocksecurityclientcreate) | — |
| [`}bedrock.security.client.delete`](#bedrocksecurityclientdelete) | — |
| [`}bedrock.security.client.group.assign`](#bedrocksecurityclientgroupassign) | — |
| [`}bedrock.security.client.password.reset`](#bedrocksecurityclientpasswordreset) | — |
| [`}bedrock.security.cube.cellsecurity.create`](#bedrocksecuritycubecellsecuritycreate) | — |
| [`}bedrock.security.cube.cellsecurity.destroy`](#bedrocksecuritycubecellsecuritydestroy) | — |
| [`}bedrock.security.evaluate.mdx`](#bedrocksecurityevaluatemdx) | 1 |
| [`}bedrock.security.evaluate.mdx.private`](#bedrocksecurityevaluatemdxprivate) | — |
| [`}bedrock.security.group.create`](#bedrocksecuritygroupcreate) | — |
| [`}bedrock.security.group.delete`](#bedrocksecuritygroupdelete) | — |
| [`}bedrock.security.object.assign`](#bedrocksecurityobjectassign) | — |
| [`}bedrock.security.refresh`](#bedrocksecurityrefresh) | — |

**Server**

| Process | Total dependencies |
|---|---|
| [`}bedrock.server.deleteallpersistentfeeders`](#bedrockserverdeleteallpersistentfeeders) | — |
| [`}bedrock.server.dir.backup`](#bedrockserverdirbackup) | 1 |
| [`}bedrock.server.dir.listcontents`](#bedrockserverdirlistcontents) | — |
| [`}bedrock.server.encrypt.directory`](#bedrockserverencryptdirectory) | 1 |
| [`}bedrock.server.encrypt.file`](#bedrockserverencryptfile) | — |
| [`}bedrock.server.executecommand`](#bedrockserverexecutecommand) | — |
| [`}bedrock.server.localize`](#bedrockserverlocalize) | — |
| [`}bedrock.server.logfile.delete`](#bedrockserverlogfiledelete) | — |
| [`}bedrock.server.savedataall`](#bedrockserversavedataall) | — |
| [`}bedrock.server.util.string.validate`](#bedrockserverutilstringvalidate) | — |
| [`}bedrock.server.wait`](#bedrockserverwait) | — |
| [`}bedrock.server.writetomessagelog`](#bedrockserverwritetomessagelog) | — |

---

## `}bedrock.cube.clone`

**Direct calls (2):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.create` | Prolog |
| `}bedrock.cube.data.copy.intercube` | Prolog |

**Indirect calls (6):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.data.export`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.data.clear`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.view.create` | Prolog |

**Indirect calls (3):**

- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.data.copy`

**Direct calls (3):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.clear` | Prolog, Epilog |
| `}bedrock.cube.data.export` | Prolog |
| `}bedrock.cube.view.create` | Prolog |

**Indirect calls (3):**

- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.data.copy.intercube`

**Direct calls (3):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.clear` | Prolog |
| `}bedrock.cube.data.export` | Prolog |
| `}bedrock.cube.view.create` | Prolog |

**Indirect calls (3):**

- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.data.export`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.view.create` | Prolog |

**Indirect calls (3):**

- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.data.hold`

**Direct calls (4):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.create` | Prolog |
| `}bedrock.cube.data.export` | Prolog |
| `}bedrock.cube.data.import` | Prolog |
| `}bedrock.hier.create` | Prolog |

**Indirect calls (5):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.data.import`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.clear` | Data |

**Indirect calls (4):**

- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.dimension.add`

**Direct calls (5):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.clone` | Prolog |
| `}bedrock.cube.create` | Prolog |
| `}bedrock.cube.data.copy.intercube` | Prolog |
| `}bedrock.cube.delete` | Prolog |
| `}bedrock.cube.rule.manage` | Prolog |

**Indirect calls (6):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.data.export`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.dimension.delete`

**Direct calls (5):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.clone` | Prolog |
| `}bedrock.cube.create` | Prolog |
| `}bedrock.cube.data.copy.intercube` | Prolog |
| `}bedrock.cube.delete` | Prolog |
| `}bedrock.cube.rule.manage` | Prolog |

**Indirect calls (6):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.data.export`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.dimension.replace`

**Direct calls (5):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.clone` | Prolog |
| `}bedrock.cube.create` | Prolog |
| `}bedrock.cube.data.copy.intercube` | Prolog |
| `}bedrock.cube.delete` | Prolog |
| `}bedrock.cube.rule.manage` | Prolog |

**Indirect calls (6):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.data.export`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.rule.manage`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create.bymdx` | Prolog |

---

## `}bedrock.cube.view.create`

**Direct calls (2):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |
| `}bedrock.hier.sub.create.bymdx` | Prolog |

**Indirect calls (1):**

- `}bedrock.hier.sub.exclude`

---

## `}bedrock.cube.viewandsubsets.delete`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.delete` | Prolog |

---

## `}bedrock.dim.clone`

**Direct calls (3):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.clone` | Epilog |
| `}bedrock.hier.sub.clone` | Epilog |
| `}bedrock.hier.unwind` | Prolog |

---

## `}bedrock.hier.clone`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.unwind` | Prolog |

---

## `}bedrock.hier.consol.delete`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create.bymdx` | Prolog |

---

## `}bedrock.hier.consol.flat.create`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.unwind` | Prolog |

---

## `}bedrock.hier.create.fromattribute`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.unwind` | Prolog |

---

## `}bedrock.hier.create.fromrollup`

**Direct calls (4):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.create.fromsubset` | Prolog |
| `}bedrock.hier.emptyconsols.delete` | Prolog |
| `}bedrock.hier.sub.create` | Prolog |
| `}bedrock.hier.unwind` | Prolog |

**Indirect calls (6):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.data.copy`
- `}bedrock.cube.data.export`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.create.fromrollup.aliasswap`

**Direct calls (9):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.copy` | Prolog |
| `}bedrock.dim.attr.create` | Prolog |
| `}bedrock.dim.attr.delete` | Epilog |
| `}bedrock.dim.attr.swapalias` | Prolog |
| `}bedrock.dim.delete` | Epilog |
| `}bedrock.hier.create.fromsubset` | Prolog |
| `}bedrock.hier.emptyconsols.delete` | Epilog |
| `}bedrock.hier.sub.create` | Prolog |
| `}bedrock.hier.unwind` | Epilog |

**Indirect calls (5):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.data.export`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.create.fromsubset`

**Direct calls (2):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.copy` | Epilog |
| `}bedrock.hier.unwind` | Prolog |

**Indirect calls (6):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.data.export`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.export`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.export` | Epilog |

**Indirect calls (4):**

- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.import`

**Direct calls (3):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.import` | Epilog |
| `}bedrock.hier.create` | Prolog |
| `}bedrock.hier.unwind` | Prolog |

**Indirect calls (5):**

- `}bedrock.cube.data.clear`
- `}bedrock.cube.view.create`
- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.create`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.exclude` | Epilog |

**Indirect calls (1):**

- `}bedrock.hier.sub.create.bymdx`

---

## `}bedrock.hier.sub.create.all`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |

**Indirect calls (2):**

- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.create.attribute.all`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |

**Indirect calls (2):**

- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.create.attribute.leaf`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |

**Indirect calls (2):**

- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.create.byelement`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |

**Indirect calls (2):**

- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.create.consolidation.all`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |

**Indirect calls (2):**

- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.create.consolidation.leaf`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |

**Indirect calls (2):**

- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.create.leaf`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create` | Prolog |

**Indirect calls (2):**

- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.hier.sub.exclude`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.hier.sub.create.bymdx` | Prolog |

---

## `}bedrock.process.template`

**Direct calls (2):**

| Callee | Section(s) |
|---|---|
| `}bedrock.cube.data.clear` | Prolog |
| `}bedrock.cube.view.create` | Prolog |

**Indirect calls (3):**

- `}bedrock.hier.sub.create`
- `}bedrock.hier.sub.create.bymdx`
- `}bedrock.hier.sub.exclude`

---

## `}bedrock.security.client.clone`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.security.client.create` | Prolog |

---

## `}bedrock.security.evaluate.mdx`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.security.evaluate.mdx.private` | Prolog |

---

## `}bedrock.server.dir.backup`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.server.savedataall` | Prolog |

---

## `}bedrock.server.encrypt.directory`

**Direct calls (1):**

| Callee | Section(s) |
|---|---|
| `}bedrock.server.encrypt.file` | Prolog |

---
