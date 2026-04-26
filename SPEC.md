Laboratory Experiment Tracking System

Context
A research laboratory needs to design a system to track their scientific experiments. Here are some aspects of the data model that will sit underneath it.

Researchers. The scientists who conduct experiments. The lab tracks their names, contact details, and roles within the lab (principal investigators, lab technicians, graduate students, and so on). Researchers collaborate on multiple projects at once.

Projects. Research initiatives that group related experiments together. Each project has a title, a description, and moves through a lifecycle from planning to active to completed (or sometimes cancelled). Multiple researchers typically collaborate on a single project.

Experiments. Individual scientific tests conducted as part of a project. Each experiment has a title, a hypothesis being tested, start and end dates, and its own lifecycle status. Every experiment belongs to exactly one project. Experiments can use multiple samples, and an experiment is sometimes a follow-up to a previous experiment (for replication, iteration, or to test a refined hypothesis).

Samples. Physical specimens used in experiments. The lab assigns each sample a unique identifier, tracks what kind of specimen it is (blood, tissue, chemical compound, soil, and so on), when it was collected, and where it's stored. A single sample can be used across multiple experiments.

Measurements. The data points produced by experiments. Measurements come in several forms: some are numeric readings with units (a concentration in mg/L, a temperature in degrees Celsius), some are categorical outcomes (positive or negative, pass or fail), and some are free-text observations written up by the researcher. New kinds of measurements are added occasionally as the lab adopts new techniques. Each measurement is associated with a specific experiment and usually references the sample it was taken from, along with a timestamp and optional notes.

1. A data model, implemented as Postgres migrations. The setup must run via Docker. The requirement is that someone should be able to clone the repo, run a single command (documented in the README), and end up with a running Postgres database containing your schema and some seed data.
2. Seed data that exercises the interesting parts of your model. Enough to demonstrate that your design actually supports the scenarios described above, including at least one project with multiple researchers, experiments that reference earlier experiments, samples used across multiple experiments, and measurements of more than one kind.
3. A README that includes:

    a. How to start the database (the single command mentioned above)
    b. Your assumptions about anything the prompt left ambiguous
    c. Insight on the key tradeoffs in your design, including at least one thing you considered and chose not to do
    d. A short list of open questions you'd want to clarify with the lab before building this out further

Implementation
- Let this run in a docker postgresql 16-alpine container 
- Make this as simple (concise) initial design that may evolve

