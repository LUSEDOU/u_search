
-- CREATE TABLE users (
--     id INTEGER PRIMARY KEY,
--     name TEXT NOT NULL,
--     lastName TEXT NOT NULL,
--     email TEXT NOT NULL,
--     role INTEGER NOT NULL,
--     UNIQUE (email)
-- );
INSERT INTO users (name, lastName, email, role)
    VALUES ( 'Admin', 'ADMIN', 'luis.dolorier.usil@gmail.com', 2),
    ( 'Maria', 'Gonzales', 'maria@usil.test', 1),
    ( 'Luis', 'Dolorier', 'luis.dolorier@usil.pe', 1),
    ( 'Jose', 'Perez', 'lusedou@gmail.com', 0),
    ( 'Carlos', 'Gonzales', 'carlos@usil.test', 0);

