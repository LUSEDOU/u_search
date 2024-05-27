part of 'in_memory_data_source.dart';

final _users = <User>[
  const User(
    id: 0,
    name: 'Admin',
    lastName: 'ADMIN',
    email: 'admin@usil.test',
    role: Role.admin,
  ),
  const User(
    id: 1,
    name: 'Maria',
    lastName: 'Gonzales',
    email: 'maria@usil.test',
    role: Role.researcher,
  ),
  const User(
    id: 2,
    name: 'Luis',
    lastName: 'Dolorier',
    email: 'luis.dolorier@usil.pe',
    role: Role.researcher,
  ),
  const User(
    id: 3,
    name: 'Jose',
    lastName: 'Perez',
    email: 'lusedou@gmail.com',
    role: Role.reviewer,
  ),
  const User(
    id: 4,
    name: 'Carlos',
    lastName: 'Gonzales',
    email: 'carlos@usil.test',
    role: Role.reviewer,
  ),
];

final _researches = <Research>[
  const Research(
    id: 0,
    researcher: 1,
    length: 10,
    title: 'Investigacion de nanotecnologia',
    uuid: 'uuid1',
  ),
  const Research(
    id: 1,
    researcher: 1,
    length: 1098123,
    title: 'Investigacion sobre el covid',
    uuid: 'uuid2',
  ),
  const Research(
    id: 2,
    researcher: 2,
    length: 10000000,
    title: 'Investigacion sobre la educacion',
    uuid: 'uuid3',
  ),
];

final _contests = <Contest>[
  const Contest(
    id: 0,
    name: 'Concurso Internacional de Investigacion',
    description: 'Se busca investigaciones de alto impacto',
    criterias: [
      Criterium(
        order: 0,
        name: 'Impacto',
        minScore: 3,
        percent: 0.25,
        description: 'Que tanto impacto tiene la investigacion',
        subCriterias: [
          Criterium(
            order: 0,
            name: 'Relevancia',
            description: 'Que tan relevante es la investigacion',
            percent: 0.5,
          ),
          Criterium(
            order: 1,
            name: 'Innovacion',
            description: 'Que tan innovadora es la investigacion',
            percent: 0.5,
          ),
        ],
      ),
      Criterium(
        order: 1,
        percent: 0.35,
        name: 'Metodologia',
        minScore: 3,
        description: 'Que tan buena es la metodologia',
        subCriterias: [
          Criterium(
            order: 0,
            name: 'Metodos',
            description: 'Que tan buenos son los metodos',
            percent: 1 / 3,
          ),
          Criterium(
            order: 1,
            name: 'Resultados',
            description: 'Que tan buenos son los resultados',
            percent: 1 / 3,
          ),
          Criterium(
            order: 2,
            name: 'Conclusiones',
            description: 'Que tan buenas son las conclusiones',
            percent: 1 / 3,
          ),
        ],
      ),
      // Single criterium
      Criterium(
        order: 2,
        name: 'Presentacion',
        minScore: 3,
        description: 'Que tan buena es la presentacion',
        percent: 0.15,
      ),
      Criterium(
        order: 3,
        name: 'Calidad',
        minScore: 3,
        description: 'Que tan buena es la calidad',
        percent: 0.25,
      ),
    ],
  ),
  const Contest(
    id: 1,
    name: 'Concurso Nacional de Investigacion',
    description: 'Se busca investigaciones de alto impacto',
    criterias: [
      Criterium(
        order: 0,
        name: 'Impacto',
        minScore: 3,
        percent: 0.5,
        description: 'Que tanto impacto tiene la investigacion',
        subCriterias: [
          Criterium(
            order: 0,
            name: 'Relevancia',
            description: 'Que tan relevante es la investigacion',
            percent: 0.5,
          ),
          Criterium(
            order: 1,
            name: 'Innovacion',
            description: 'Que tan innovadora es la investigacion',
            percent: 0.5,
          ),
        ],
      ),
      Criterium(
        order: 1,
        percent: 0.5,
        name: 'Metodologia',
        minScore: 3,
        description: 'Que tan buena es la metodologia',
        subCriterias: [
          Criterium(
            order: 0,
            name: 'Metodos',
            description: 'Que tan buenos son los metodos',
            percent: 0.5,
          ),
          Criterium(
            order: 1,
            name: 'Resultados',
            description: 'Que tan buenos son los resultados',
            percent: 0.5,
          ),
        ],
      ),
    ],
  ),
];

final _reviews = <Review>[
  const Review(
    id: 0,
    calification: Calification(
      order: 0,
      score: 3.105,
      subCalifications: [
        Calification(
          order: 0,
          score: 5,
          subCalifications: [
            Calification(
              order: 0,
              score: 5,
              comment: 'Alta relevancia',
            ),
            Calification(
              order: 1,
              score: 5,
              comment: 'Muy innovador',
            ),
          ],
        ),
        Calification(
          order: 1,
          score: 3,
          subCalifications: [
            Calification(
              order: 0,
              score: 3,
              comment: 'Mediocre uso de metodos',
            ),
            Calification(
              order: 1,
              score: 3,
              comment: 'Resultados no son claros',
            ),
            Calification(
              order: 2,
              score: 3,
              comment: 'Conclusiones no son claras',
            ),
          ],
        ),
        Calification(
          order: 2,
          score: 5,
          comment: 'Excelente innovacion',
        ),
        Calification(
          order: 3,
          score: 4,
          comment: 'Buena presentacion',
        ),
      ],
    ),
    criterias: [
      Criterium(
        order: 0,
        name: 'Impacto',
        minScore: 3,
        percent: 0.25,
        description: 'Que tanto impacto tiene la investigacion',
        subCriterias: [
          Criterium(
            order: 0,
            name: 'Relevancia',
            description: 'Que tan relevante es la investigacion',
            percent: 0.5,
          ),
          Criterium(
            order: 1,
            name: 'Innovacion',
            description: 'Que tan innovadora es la investigacion',
            percent: 0.5,
          ),
        ],
      ),
      Criterium(
        order: 1,
        percent: 0.35,
        name: 'Metodologia',
        minScore: 3,
        description: 'Que tan buena es la metodologia',
        subCriterias: [
          Criterium(
            order: 0,
            name: 'Metodos',
            description: 'Que tan buenos son los metodos',
            percent: 1 / 3,
          ),
          Criterium(
            order: 1,
            name: 'Resultados',
            description: 'Que tan buenos son los resultados',
            percent: 1 / 3,
          ),
          Criterium(
            order: 2,
            name: 'Conclusiones',
            description: 'Que tan buenas son las conclusiones',
            percent: 1 / 3,
          ),
        ],
      ),
      // Single criterium
      Criterium(
        order: 2,
        name: 'Presentacion',
        minScore: 3,
        description: 'Que tan buena es la presentacion',
        percent: 0.15,
      ),
      Criterium(
        order: 3,
        name: 'Calidad',
        minScore: 3,
        description: 'Que tan buena es la calidad',
        percent: 0.25,
      ),
    ],
  ),
];

final _applications = <Application>[
  const Application(
    id: 0,
    contest: 0,
    research: 0,
    review: 0,
    reviewer: 3,
  ),
  const Application(
    id: 1,
    contest: 1,
    research: 1,
    reviewer: 4,
  ),
  const Application(
    id: 2,
    contest: 1,
    research: 2,
  ),
];

final _emailTokens = <String, String>{
  'admin': 'luis.dolorier.usil@gmail.com',
};

final _tokens = <int, String>{
  0: 'admin',
  1: 'juan',
  2: 'maria',
  3: 'jose',
  4: 'carlos',
};
