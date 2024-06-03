INSERT INTO users (id, name, lastName, email, role)
VALUES
(0, 'Admin', 'ADMIN', 'luis.dolorier.usil@gmail.com', 1),
(1, 'Maria', 'Gonzales', 'maria@usil.test', 2),
(2, 'Luis', 'Dolorier', 'luis.dolorier@usil.pe', 2),
(3, 'Jose', 'Perez', 'lusedou@gmail.com', 3),
(4, 'Carlos', 'Gonzales', 'carlos@usil.test', 3);

INSERT INTO researches (id, researcher, length, title, uuid)
VALUES
(0, 1, 10, 'Investigacion de nanotecnologia', 'uuid1'),
(1, 1, 1098123, 'Investigacion sobre el covid', 'uuid2'),
(2, 2, 10000000, 'Investigacion sobre la educacion', 'uuid3');

INSERT INTO contests (id, name, description, criterias)
VALUES
(0, 'Concurso Internacional de Investigacion', 'Se busca investigaciones de alto impacto', '[{"order":0,"name":"Impacto","minScore":3,"percent":0.25,"description":"Que tanto impacto tiene la investigacion","subCriterias":[{"order":0,"name":"Relevancia","description":"Que tan relevante es la investigacion","percent":0.5},{"order":1,"name":"Innovacion","description":"Que tan innovadora es la investigacion","percent":0.5}]},{"order":1,"percent":0.35,"name":"Metodologia","minScore":3,"description":"Que tan buena es la metodologia","subCriterias":[{"order":0,"name":"Metodos","description":"Que tan buenos son los metodos","percent":1/3},{"order":1,"name":"Resultados","description":"Que tan buenos son los resultados","percent":1/3},{"order":2,"name":"Conclusiones","description":"Que tan buenas son las conclusiones","percent":1/3}]},{"order":2,"name":"Presentacion","minScore":3,"description":"Que tan buena es la presentacion","percent":0.15},{"order":3,"name":"Calidad","minScore":3,"description":"Que tan buena es la calidad","percent":0.25}]'),
(1, 'Concurso Nacional de Investigacion', 'Se busca investigaciones de alto impacto', '[{"order":0,"name":"Impacto","minScore":3,"percent":0.5,"description":"Que tanto impacto tiene la investigacion","subCriterias":[{"order":0,"name":"Relevancia","description":"Que tan relevante es la investigacion","percent":0.5},{"order":1,"name":"Innovacion","description":"Que tan innovadora es la investigacion","percent":0.5}]},{"order":1,"percent":0.5,"name":"Metodologia","minScore":3,"description":"Que tan buena es la metodologia","subCriterias":[{"order":0,"name":"Metodos","description":"Que tan buenos son los metodos","percent":0.5},{"order":1,"name":"Resultados","description":"Que tan buenos son los resultados","percent":0.5}]}]');

INSERT INTO reviews (id, calification, criterias)
VALUES
(0, '{"order":0,"score":3.105,"subCalifications":[{"order":0,"score":5,"subCalifications":[{"order":0,"score":5,"comment":"Alta relevancia"},{"order":1,"score":5,"comment":"Muy innovador"}]},{"order":1,"score":3,"subCalifications":[{"order":0,"score":3,"comment":"Mediocre uso de metodos"},{"order":1,"score":3,"comment":"Resultados no son claros"},{"order":2,"score":3,"comment":"Conclusiones no son claras"}]},{"order":2,"score":5,"comment":"Excelente innovacion"},{"order":3,"score":4,"comment":"Buena presentacion"}],"subCriterias":[{"order":0,"name":"Impacto","description":"Que tanto impacto tiene la investigacion","percent":0.25,"subCriterias":[{"order":0,"name":"Relevancia","description":"Que tan relevante es la investigacion","percent":0.5},{"order":1,"name":"Innovacion","description":"Que tan innovadora es la investigacion","percent":0.5}]},{"order":1,"name":"Metodologia","description":"Que tan buena es la metodologia","percent":0.35,"subCriterias":[{"order":0,"name":"Metodos","description":"Que tan buenos son los metodos","percent":1/3},{"order":1,"name":"Resultados","description":"Que tan buenos son los resultados","percent":1/3},{"order":2,"name":"Conclusiones","description":"Que tan buenas son las conclusiones","percent":1/3}]},{"order":2,"name":"Presentacion","description":"Que tan buena es la presentacion","percent":0.15},{"order":3,"name":"Calidad","description":"Que tan buena es la calidad","percent":0.25}]}', '[{"order":0,"name":"Impacto","minScore":3,"percent":0.25,"description":"Que tanto impacto tiene la investigacion","subCriterias":[{"order":0,"name":"Relevancia","description":"Que tan relevante es la investigacion","percent":0.5},{"order":1,"name":"Innovacion","description":"Que tan innovadora es la investigacion","percent":0.5}]},{"order":1,"percent":0.35,"name":"Metodologia","minScore":3,"description":"Que tan buena es la metodologia","subCriterias":[{"order":0,"name":"Metodos","description":"Que tan buenos son los metodos","percent":1/3},{"order":1,"name":"Resultados","description":"Que tan buenos son los resultados","percent":1/3},{"order":2,"name":"Conclusiones","description":"Que tan buenas son las conclusiones","percent":1/3}]},{"order":2,"name":"Presentacion","minScore":3,"description":"Que tan buena es la presentacion","percent":0.15},{"order":3,"name":"Calidad","minScore":3,"description":"Que tan buena es la calidad","percent":0.25}]');


INSERT INTO applications (id, contest, research, review, reviewer)
VALUES
(0, 0, 0, 0, 3),
(1, 1, 1, NULL, 4),
(2, 1, 2, NULL, NULL);

INSERT INTO email_tokens (token, email)
VALUES
( 'admin', 'luis.dolorier.usil@gmail.com'),
( 'luis', 'luis.dolorier@usil.pe'),
( 'jose', 'lusedou@gmail.com');

INSERT INTO tokens (user, token)
VALUES
( 0, 'admin'),
( 1, 'juan'),
( 2, 'maria'),
( 3, 'jose'),
( 4, 'carlos');
