-- Researchers
INSERT INTO researchers (id, name, email, role) VALUES
('00000000-0000-0000-0000-000000000001', 'Dr. Alice', 'alice@lab.com', 'PI'),
('00000000-0000-0000-0000-000000000002', 'Bob', 'bob@lab.com', 'Technician'),
('00000000-0000-0000-0000-000000000003', 'Charlie', 'charlie@lab.com', 'Graduate Student');

-- Project
INSERT INTO projects (id, title, description, status) VALUES
('10000000-0000-0000-0000-000000000001', 'Cancer Biomarker Study', 'Study on biomarkers', 'ACTIVE');

-- Project researchers
INSERT INTO project_researchers VALUES
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001'),
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002'),
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000003');

-- Samples
INSERT INTO samples (id, external_id, specimen_type, collected_at, storage_location) VALUES
('20000000-0000-0000-0000-000000000001', 'S-001', 'Blood', now(), 'Freezer A'),
('20000000-0000-0000-0000-000000000002', 'S-002', 'Tissue', now(), 'Freezer B');

-- Experiments
INSERT INTO experiments (id, project_id, title, hypothesis, status, start_date) VALUES
('30000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'Baseline Test', 'Baseline levels', 'COMPLETED', '2026-01-01');

INSERT INTO experiments (id, project_id, title, hypothesis, status, start_date, parent_experiment_id) VALUES
('30000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 'Follow-up Test', 'Improved detection', 'RUNNING', '2026-02-01', '30000000-0000-0000-0000-000000000001');

-- Experiment-Sample links
INSERT INTO experiment_samples VALUES
('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001'),
('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000002'),
('30000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000001');

-- Measurements
-- Numeric
INSERT INTO measurements (
    experiment_id, sample_id, type, value_numeric, unit, measured_at
) VALUES (
    '30000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000001',
    'NUMERIC',
    5.6,
    'mg/L',
    now()
);

-- Categorical
INSERT INTO measurements (
    experiment_id, sample_id, type, value_categorical, measured_at
) VALUES (
    '30000000-0000-0000-0000-000000000001',
    '20000000-0000-0000-0000-000000000002',
    'CATEGORICAL',
    'POSITIVE',
    now()
);

-- Text
INSERT INTO measurements (
    experiment_id, type, value_text, measured_at, notes
) VALUES (
    '30000000-0000-0000-0000-000000000002',
    'TEXT',
    'Unexpected reaction observed',
    now(),
    'Requires further study'
);