import 'package:u_search_api/u_search_api.dart';

const shortLoremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';
const longLoremIpsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl. Donec euismod, nisl eget aliquet ultricies, nunc nisl aliquam nunc, quis aliquet nisl nunc quis nisl.';

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

List<SubCriteria> subCriteriasListFactory(int parentIndex, int length) =>
    List.generate(
      length,
      (index) => subCriteriaFactory(
        index + parentIndex,
        percent: (100 / length).roundToDouble(),
      ),
    );

Criteria criteriaFactory(
  int index, {
  int subCriteriasLength = 2,
}) =>
    Criteria(
      id: index,
      name: 'Criteria $index',
      description: shortLoremIpsum,
      subCriterias: subCriteriasListFactory(index, subCriteriasLength),
    );

List<Criteria> criteriasListFactory(int parentIndex, int length) =>
    List.generate(
      length,
      (index) => criteriaFactory(index + parentIndex),
    );

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

Apply applyFactory(
  int index, {
  int criteriasLength = 2,
}) =>
    Apply(
      id: index,
      contest: contestFactory(index, criteriasLength: criteriasLength),
    );

List<Apply> appliesListFactory(int length) => List.generate(
      length,
      (index) => applyFactory(index),
    );

User userFactory() => const User(
      id: 1,
      name: 'User',
      email: 'user@demo.com',
    );
