-- build_dev.sql
-- Create Tables for SQLite3 Database

-- Users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    lastName TEXT NOT NULL,
    email TEXT NOT NULL,
    role INTEGER NOT NULL,
    UNIQUE (email)
);

CREATE INDEX users_role_index ON users (role);

DROP TABLE IF EXISTS access_tokens;
CREATE TABLE access_tokens (
    token TEXT NOT NULL,
    email TEXT NOT NULL,
    FOREIGN KEY (email) REFERENCES users(email),
    UNIQUE (token)
);

CREATE INDEX access_tokens_user_index ON access_tokens (email);
CREATE INDEX access_tokens_token_index ON access_tokens (token);

-- -- Research
-- CREATE TABLE researchs (
--     id INTEGER PRIMARY KEY,
--     length INTEGER NOT NULL,
--     title TEXT NOT NULL,
--     uuid TEXT NOT NULL,
--     researcher INTEGER NOT NULL,
--     FOREIGN KEY (researcher) REFERENCES users(id),
--     UNIQUE (uuid)
-- );
-- CREATE INDEX researchs_researcher_index ON researchs (researcher);
--
-- -- Criteria
-- CREATE TABLE criterias (
--     id INTEGER PRIMARY KEY,
--     name TEXT NOT NULL,
--     description TEXT NOT NULL
-- );
--
-- -- Criteria - (Sub)Criteria
-- -- criteria_id -> criteria.id
-- CREATE TABLE criteria_subcriteria (
--     criteria_id INTEGER NOT NULL,
--     subcriteria_id INTEGER NOT NULL,
--     FOREIGN KEY (criteria_id) REFERENCES criterias(id),
--     FOREIGN KEY (subcriteria_id) REFERENCES criterias(id),
--     UNIQUE (subcriteria_id)
-- );
--
-- /* Foreign Indexes */
-- CREATE INDEX criteria_subcriteria_criteria_id_index ON criteria_subcriteria (criteria_id);
-- CREATE INDEX criteria_subcriteria_subcriteria_id_index ON criteria_subcriteria (subcriteria_id);
--
-- /* Unique Indexes */
-- /* A subcriteria cannot be repeated, can only appear one */
-- CREATE UNIQUE INDEX criteria_subcriteria_subcriteria_id_uindex ON criteria_subcriteria (subcriteria_id);
--
-- -- Contests
-- CREATE TABLE contests (
--     id INTEGER PRIMARY KEY,
--     name TEXT NOT NULL,
--     description TEXT NOT NULL,
--     FOREIGN KEY (research) REFERENCES researchs(id)
-- );
--
-- -- Contest - Criteria
-- CREATE TABLE contest_criteria (
--     contest_id INTEGER NOT NULL,
--     criteria_id INTEGER NOT NULL,
--     FOREIGN KEY (contest_id) REFERENCES contests(id),
--     FOREIGN KEY (criteria_id) REFERENCES criterias(id)
-- );
--
-- CREATE INDEX contest_criteria_contest_id_index ON contest_criteria (contest_id);
-- CREATE INDEX contest_criteria_criteria_id_index ON contest_criteria (criteria_id);
--
-- -- Applications
-- CREATE TABLE applications (
--     id INTEGER PRIMARY KEY,
--     contest INTEGER NOT NULL,
--     researcher INTEGER REFERENCES users(id),
--     review INTEGER REFERENCES users(id),
--     FOREIGN KEY (contest_id) REFERENCES contests(id)
-- );
--
-- CREATE INDEX applications_contest_index ON applications (contest);
-- CREATE INDEX applications_researcher_index ON applications (researcher);
--
-- -- Reviews
-- CREATE TABLE reviews (
--     id INTEGER PRIMARY KEY,
--     application INTEGER NOT NULL,
--     reviewer INTEGER NOT NULL,
--     score INTEGER NOT NULL,
--     FOREIGN KEY (application) REFERENCES applications(id),
--     FOREIGN KEY (reviewer) REFERENCES users(id)
-- );
