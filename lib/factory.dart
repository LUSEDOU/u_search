import 'package:data_repository/data_repository.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

const shortLoremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
const longLoremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc eu nisl. Donec euismod, nisl eget aliquam aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc eu nisl. Donec euismod, nisl eget aliquam aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc eu nisl. Donec euismod, nisl eget aliquam aliquam, nunc nisl aliquet nunc, quis aliquam nisl nunc eu nisl.';

SubCriteria subCriteriaFactory(
  int index, {
  double percent = 100,
}) =>
    SubCriteria(
      id: index,
      name: 'SubCriteria $index',
      description: shortLoremIpsum,
      percent: percent,
    );

List<SubCriteria> subCriteriasListFactory(
  int parentIndex,
  int length, {
  int? sublist,
}) =>
    List.generate(
      length,
      (index) => subCriteriaFactory(
        index + parentIndex,
        percent: 1 / (sublist ?? length),
      ),
    );

Criteria criteriaFactory(
  int index, {
  required List<SubCriteria> subCriterias,
}) =>
    Criteria(
      id: index,
      name: 'Criteria $index',
      description: shortLoremIpsum,
      subCriterias: subCriterias,
      percent: 1 / subCriterias.length,
    );

List<Criteria> criteriasListFactory(int parentIndex, int length) {
  final subCriterias = subCriteriasListFactory(
    parentIndex,
    length * 2,
    sublist: 2,
  );

  return List.generate(
    length,
    (index) => criteriaFactory(
      index + parentIndex,
      subCriterias: subCriterias.sublist(index * 2, (index + 1) * 2),
    ),
  );
}

Contest contestFactory(
  int index, {
  int criteriasLength = 2,
}) =>
    Contest(
      id: index,
      name: 'Contest $index',
      description: longLoremIpsum,
      criterias: criteriasListFactory(index, criteriasLength),
    );

List<Contest> contestsListFactory(int length) => List.generate(
      length,
      contestFactory,
    );

Review reviewFactory(
  int index, {
  required Contest contest,
  int criteriasLength = 2,
}) =>
    Review(
      id: index,
      califications: contest.califications
          .map(
            (e) => e
                .dirty(
                  score: '5',
                  comment: shortLoremIpsum,
                )
                .model,
          )
          .toList(),
    );

Apply applyFactory(
  int index, {
  int criteriasLength = 2,
}) {
  final contest = contestFactory(index, criteriasLength: criteriasLength);
  return Apply(
    id: index,
    contest: contest,
    research: researchFactory(index),
    review: reviewFactory(index, contest: contest),
  );
}

Apply applyWithoutReviewFactory(
  int index, {
  int criteriasLength = 2,
}) {
  final contest = contestFactory(index, criteriasLength: criteriasLength);
  return Apply(
    id: index,
    contest: contest,
    research: researchFactory(index),
  );
}

List<Apply> appliesListFactory(int length) => List.generate(
      length,
      applyFactory,
    );

Research researchFactory(
  int index,
) =>
    Research(
      id: index,
      length: 50,
      title: 'Research $index',
      researcher: Researcher(
        id: index,
        user: userFactory(),
      ),
      uuid: '123',
    );

User userFactory() => const User(
      id: '123',
      name: 'User',
      email: 'user@demo.com',
    );

Role roleFactory(int id) => Role(
      id: id,
      user: userFactory(),
      type: RoleType.researcher,
    );
