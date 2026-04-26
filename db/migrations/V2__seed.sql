-- Seed Data to exercise the model requirements

-- 1. Researchers
INSERT INTO researchers (id, name, email, role) VALUES
('00000000-0000-0000-0000-000000000001', 'Dr. Aris Thorne', 'a.thorne@lab.edu', 'Principal Investigator'),
('00000000-0000-0000-0000-000000000002', 'Sarah Jenkins', 's.jenkins@lab.edu', 'Lab Technician'),
('00000000-0000-0000-0000-000000000003', 'Marco Rossi', 'm.rossi@lab.edu', 'Graduate Student');

-- 2. Project with multiple researchers
INSERT INTO projects (id, title, description, status) VALUES
('10000000-0000-0000-0000-000000000001', 'Project Phoenix', 'Investigating soil regeneration after wildfires', 'ACTIVE');

INSERT INTO project_researchers (project_id, researcher_id) VALUES
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000001'),
('10000000-0000-0000-0000-000000000001', '00000000-0000-0000-0000-000000000002');

-- 3. Samples used across multiple experiments
INSERT INTO samples (id, external_id, specimen_type, collected_at, storage_location) VALUES
('20000000-0000-0000-0000-000000000001', 'SOIL-A1', 'Soil', '2023-10-01 10:00:00Z', 'Cabinet 4'),
('20000000-0000-0000-0000-000000000002', 'WAT-B5', 'Water', '2023-10-02 14:30:00Z', 'Fridge 2');

-- 4. Experiments with lineage (Follow-up)
INSERT INTO experiments (id, project_id, title, hypothesis, status, start_date, end_date) VALUES
('30000000-0000-0000-0000-000000000001', '10000000-0000-0000-0000-000000000001', 'Initial PH Scan', 'Soil is highly acidic', 'COMPLETED', '2023-11-01', '2023-11-02');

-- Follow-up experiment
INSERT INTO experiments (id, project_id, title, hypothesis, status, start_date, parent_experiment_id) VALUES
('30000000-0000-0000-0000-000000000002', '10000000-0000-0000-0000-000000000001', 'PH Neutralization Test', 'Lime treatment will normalize PH', 'RUNNING', '2023-12-01', '30000000-0000-0000-0000-000000000001');

-- Link samples to experiments (demonstrating reuse of SOIL-A1)
INSERT INTO experiment_samples (experiment_id, sample_id) VALUES
('30000000-0000-0000-0000-000000000001', '20000000-0000-0000-0000-000000000001'),
('30000000-0000-0000-0000-000000000002', '20000000-0000-0000-0000-000000000001');

-- 5. Measurements of multiple kinds
-- Numeric Measurement
INSERT INTO measurements (experiment_id, sample_id, type, value_numeric, unit, measured_at) VALUES
(
    '30000000-0000-0000-0000-000000000001', 
    '20000000-0000-0000-0000-000000000001', 
    'NUMERIC', 
    4.2, 
    'pH', 
    '2023-11-01 12:00:00Z'
);

-- Categorical Measurement
INSERT INTO measurements (experiment_id, sample_id, type, value_categorical, measured_at) VALUES
(
    '30000000-0000-0000-0000-000000000001', 
    '20000000-0000-0000-0000-000000000002', 
    'CATEGORICAL', 
    'PASS', 
    '2023-11-01 13:00:00Z'
);

-- Text Observation
INSERT INTO measurements (experiment_id, type, value_text, measured_at, notes) VALUES
(
    '30000000-0000-0000-0000-000000000002', 
    'TEXT', 
    'Soil texture appears more granular after initial treatment.', 
    '2023-12-02 09:00:00Z',
    'Observation by Sarah Jenkins'
);