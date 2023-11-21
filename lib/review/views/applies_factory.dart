import 'package:u_search_api/u_search_api.dart';

const loreIpsum =
    '    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
const miniLoreIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';

final apply1 = Apply(
  id: 1,
  contest: Contest(
    id: 1,
    name: 'First Contest',
    description: loreIpsum,
    criterias: List.generate(
      4,
      (index) => Criteria(
        id: index,
        name: 'Criteria $index',
        description: loreIpsum,
        minScore: 4,
        maxScore: 5,
        percent: 0.25,
        subCriterias: List.generate(
          3,
          (index2) => SubCriteria(
            id: index + index2,
            name: 'SubCriteria ${index + index2}',
            minScore: 4,
            description: loreIpsum,
            percent: 1 / 3,
          ),
        ),
      ),
    ),
  ),
  review: Review(
    id: 1,
    califications: List.generate(
      12,
      (index) => Calification(
        id: index,
        score: index % 2 == 0 ? 5 : 3,
        comment: loreIpsum,
        subCriteria: SubCriteria(
          id: index,
        ),
      ),
    ),
  ),
);

final apply2 = Apply(
  id: 2,
  contest: Contest(
    id: 2,
    name: 'Second Contest',
    description: loreIpsum,
    criterias: List.generate(
      2,
      (index) => Criteria(
        id: index,
        name: 'Criteria $index',
        description: loreIpsum,
        minScore: 4,
        maxScore: 5,
        percent: 0.5,
        subCriterias: List.generate(
          2,
          (index2) => SubCriteria(
            id: (index * 2) + index2,
            name: 'SubCriteria ${(index * 2) + index2}',
            minScore: 4,
            description: loreIpsum,
            percent: 0.5,
          ),
        ),
      ),
    ),
  ),
);
