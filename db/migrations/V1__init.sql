-- Enable UUID support
-- =========================
-- ENUMS
-- =========================
CREATE TYPE project_status AS ENUM ('PLANNING', 'ACTIVE', 'COMPLETED', 'CANCELLED');
CREATE TYPE experiment_status AS ENUM ('PLANNING', 'RUNNING', 'COMPLETED', 'FAILED');

CREATE TYPE measurement_type AS ENUM ('NUMERIC', 'CATEGORICAL', 'TEXT');

-- =========================
-- RESEARCHERS
-- =========================
CREATE TABLE researchers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    role TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- =========================
-- PROJECTS
-- =========================
CREATE TABLE projects (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    description TEXT,
    status project_status NOT NULL DEFAULT 'PLANNING',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Many-to-many: researchers <-> projects
CREATE TABLE project_researchers (
    project_id UUID REFERENCES projects(id) ON DELETE CASCADE,
    researcher_id UUID REFERENCES researchers(id) ON DELETE CASCADE,
    PRIMARY KEY (project_id, researcher_id)
);

-- =========================
-- EXPERIMENTS
-- =========================
CREATE TABLE experiments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    project_id UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    hypothesis TEXT,
    status experiment_status DEFAULT 'PLANNING',
    start_date TIMESTAMPTZ,
    end_date TIMESTAMPTZ,

    -- self reference (lineage)
    parent_experiment_id UUID REFERENCES experiments(id),

    created_at TIMESTAMPTZ DEFAULT now()
);

-- =========================
-- SAMPLES
-- =========================
CREATE TABLE samples (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    external_id TEXT UNIQUE NOT NULL, -- The unique identifier mentioned in spec
    specimen_type TEXT NOT NULL,
    collected_at TIMESTAMPTZ,
    storage_location TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Many-to-many: experiments <-> samples
CREATE TABLE experiment_samples (
    experiment_id UUID REFERENCES experiments(id) ON DELETE CASCADE,
    sample_id UUID REFERENCES samples(id) ON DELETE CASCADE,
    PRIMARY KEY (experiment_id, sample_id)
);

-- =========================
-- MEASUREMENTS
-- =========================
CREATE TABLE measurements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    experiment_id UUID NOT NULL REFERENCES experiments(id) ON DELETE CASCADE,
    sample_id UUID REFERENCES samples(id),

    type measurement_type NOT NULL,

    -- Numeric
    value_numeric DOUBLE PRECISION,
    unit TEXT,

    -- Categorical
    value_categorical TEXT,

    -- Text
    value_text TEXT,

    -- extensibility (future-proofing)
    extra JSONB,

    measured_at TIMESTAMPTZ NOT NULL,
    notes TEXT,

    created_at TIMESTAMPTZ DEFAULT now(),

    -- Ensure only one value column is used
    CONSTRAINT one_value_check CHECK (
        (type = 'NUMERIC' AND value_numeric IS NOT NULL AND value_categorical IS NULL AND value_text IS NULL)
        OR
        (type = 'CATEGORICAL' AND value_categorical IS NOT NULL AND value_numeric IS NULL AND value_text IS NULL)
        OR
        (type = 'TEXT' AND value_text IS NOT NULL AND value_numeric IS NULL AND value_categorical IS NULL)
    )
);