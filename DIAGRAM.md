# Entity Relationship Diagram

This diagram represents the logical relationships within the Laboratory Experiment Tracking System.

```text
  +-------------+          +---------------------+          +------------+
  | RESEARCHERS | <------> | PROJECT_RESEARCHERS | <------> |  PROJECTS  |
  +-------------+          +---------------------+          +------------+
                                                                  |
                                                                  | (1:N)
                                                                  |
                                                           +-------------+
                                                +----------| EXPERIMENTS | <---+
                                                |          +-------------+     | (Lineage)
                                                |                 |            |
                                                | (1:N)           | (M:N)      |
                                                |                 |            |
                                        +--------------+   +--------------------+
                                        | MEASUREMENTS |   | EXPERIMENT_SAMPLES |
                                        +--------------+   +--------------------+
                                                |                 |
                                                | (0:1)           |
                                                |                 |
                                                +--------+ +------+
                                                         | |
                                                     +---------+
                                                     | SAMPLES |
                                                     +---------+
```

### Key Relationship Notes:
- **Project Researchers**: A join table allowing multiple researchers to collaborate on multiple projects.
- **Experiment Lineage**: The `experiments` table has a self-reference (`parent_experiment_id`) to track follow-up studies.
- **Experiment Samples**: A join table supporting the requirement that a single sample can be used across multiple experiments.
- **Measurements**: Each measurement belongs to one experiment and optionally references the specific sample it was derived from.
- **Polymorphic Values**: Measurements use a discriminator-based approach (one table with multiple value columns) to handle Numeric, Categorical, and Text data.