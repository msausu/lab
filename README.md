# README

## Run

```bash
docker-compose up  # or podman-compose up
```

Database will be available at:

```
localhost:5432
user: lab
password: lab
db: labdb
```

---

## Assumptions

* A researcher has a **single role string** (not normalized into a roles table)
* Measurements belong to exactly one experiment, optionally one sample
* Experiment lineage is **single-parent** (tree, not DAG)
* Units are stored as plain text (no unit system enforcement)
* No versioning/audit history yet

---

## Key Tradeoffs

### 1. Measurement Modeling

**Chosen:** typed columns + constraint + JSONB
**Alternative rejected:** full EAV model

* EAV is more flexible but kills query performance and readability
* This hybrid gives:

  * strong constraints
  * extensibility via `extra`
  * simple querying for common cases

---

### 2. Roles as TEXT vs normalized table

**Chosen:** TEXT
**Rejected:** roles table

* Simpler, avoids premature complexity
* Easy to normalize later if needed

---

### 3. Experiment lineage

**Chosen:** self-reference (parent_id)
**Rejected:** join table for graph

* Most use cases are linear or tree-like
* Simpler queries
* Upgrade path exists if DAG becomes necessary

---

### 4. Sample reuse

Explicit M:N join table

* Avoids duplication
* Matches real lab reuse patterns

---

## Open Questions

1. Do experiments ever branch into multiple parents (true DAG)?
2. Do measurements require strict schemas per experiment type?
3. Should units be standardized (e.g., UCUM)?
4. Is audit/history (who changed what) required?
5. Do samples degrade or change state over time (versioning)?
6. Any compliance constraints (HIPAA, GLP, etc.)?
