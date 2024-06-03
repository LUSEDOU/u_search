-- SQLite3
-- db.sql

-- User:
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    lastName VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    role INTEGER NOT NULL
);

-- Researches
CREATE TABLE IF NOT EXISTS researches (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    uuid VARCHAR(255) NOT NULL,
    length INTEGER NOT NULL,
    researcher INTEGER NOT NULL,
    FOREIGN KEY (researcher) REFERENCES users(id)
);

-- Contests
CREATE TABLE IF NOT EXISTS contests (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    criterias JSON NOT NULL
);

-- Reviews
CREATE TABLE IF NOT EXISTS reviews (
    id SERIAL PRIMARY KEY,
    calification JSON DEFAULT NULL,
    criterias JSON NOT NULL
);

-- Applications
CREATE TABLE IF NOT EXISTS applications (
    id SERIAL PRIMARY KEY,
    contest INTEGER NOT NULL,
    research INTEGER NOT NULL,
    review INTEGER DEFAULT NULL,
    reviewer INTEGER DEFAULT NULL,
    FOREIGN KEY (contest) REFERENCES contests(id),
    FOREIGN KEY (research) REFERENCES researches(id),
    FOREIGN KEY (review) REFERENCES reviews(id),
    FOREIGN KEY (reviewer) REFERENCES users(id)
);

-- Email Tokens
CREATE TABLE IF NOT EXISTS email_tokens (
    token VARCHAR(255) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    FOREIGN KEY (email) REFERENCES users(email)
);

-- Tokens
CREATE TABLE IF NOT EXISTS tokens (
    user INTEGER NOT NULL,
    token VARCHAR(255) NOT NULL,
    FOREIGN KEY (user) REFERENCES users(id)
);
