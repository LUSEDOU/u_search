part of 'in_memory_data_source.dart';

final _contests = <Contest>[
  const Contest(
    id: 0,
    name: 'Contest 1',
    description: 'Description of 1',
    criterias: [
      Criterium(
        id: 0,
        name: 'Criterium 0',
        description: 'Description of 0',
        subCriterias: [
          SubCriterium(
            id: 0,
            name: 'SubCriterium 0',
            description: 'Description of 0',
          ),
          SubCriterium(
            id: 1,
            name: 'SubCriterium 1',
            description: 'Description of 1',
          ),
        ],
      ),
      Criterium(
        id: 1,
        name: 'Criterium 1',
        description: 'Description of 1',
        subCriterias: [
          SubCriterium(
            id: 0,
            name: 'SubCriterium 0',
            description: 'Description of 0',
          ),
          SubCriterium(
            id: 1,
            name: 'SubCriterium 1',
            description: 'Description of 1',
          ),
        ],
      ),
    ],
  ),
  const Contest(
    id: 1,
    name: 'Contest 2',
    description: 'Description of 2',
    criterias: [
      Criterium(
        id: 0,
        name: 'Criterium 0',
        description: 'Description of 0',
        subCriterias: [
          SubCriterium(
            id: 0,
            name: 'SubCriterium 0',
            description: 'Description of 0',
          ),
          SubCriterium(
            id: 1,
            name: 'SubCriterium 1',
            description: 'Description of 1',
          ),
        ],
      ),
      Criterium(
        id: 1,
        name: 'Criterium 1',
        description: 'Description of 1',
        subCriterias: [
          SubCriterium(
            id: 0,
            name: 'SubCriterium 0',
            description: 'Description of 0',
          ),
          SubCriterium(
            id: 1,
            name: 'SubCriterium 1',
            description: 'Description of 1',
          ),
        ],
      ),
    ],
  ),
];

final _users = <User>[
  const User(
    id: 0,
    name: 'Luis',
    lastName: 'Gonzales',
    email: 'luis@usil.pe',
  ),
  const User(
    id: 1,
    name: 'Juan',
    lastName: 'Perez',
    email: 'juan@usil.pe',
  ),
  const User(
    id: 2,
    name: 'Maria',
    lastName: 'Gonzales',
    email: 'maria@usil.pe',
  ),
  const User(
    id: 3,
    name: 'Jose',
    lastName: 'Perez',
    email: 'jose@usil.pe',
  ),
  const User(
    id: 4,
    name: 'Carlos',
    lastName: 'Gonzales',
    email: 'carlos@usil.pe',
  ),
];

final _researchs = <Research>[
  Research(
    researcher: _users[0],
    length: 10,
    title: 'Research 1',
    uuid: 'uuid1',
  ),
  Research(
    researcher: _users[2],
    length: 10,
    title: 'Research 2',
    uuid: 'uuid2',
  ),
];

final _applications = <Apply>[
  Apply(contest: _contests[0], research: _researchs[0], id: 0),
];
