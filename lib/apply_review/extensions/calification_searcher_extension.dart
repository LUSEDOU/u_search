import 'package:data_repository/data_repository.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/apply_review/extensions/double_score_extension.dart';
import 'package:u_search_flutter/utils/dart_extensions.dart';

extension CalificationSearcher<T> on Iterable<CalificationForm> {
  static List<CalificationForm> fromContest(
    Contest contest,
  ) =>
      contest.criterias
          .expand((element) => element.subCriterias)
          .map(CalificationForm.fromSubCriteria)
          .toList();

  CalificationForm? getFromSubCriteria(SubCriteria subCriteria) =>
      firstWhereOrNull((element) => element.id == subCriteria.id);

  Iterable<CalificationForm> getFromCriteria(Criteria criteria) =>
      criteria.subCriterias
          .map((subCriteria) => getFromSubCriteria(subCriteria))
          .whereNotNull()
          .cast<CalificationForm>();

  double scoreFrom(Criteria criteria) => getFromCriteria(criteria)
      .fold<double>(
        0,
        (previousValue, element) => previousValue + element.ponderateScore,
      )
      .asScore;

  double totalScore(List<Criteria> criterias) => criterias
      .map((e) => scoreFrom(e) * e.percent)
      .fold<double>(
        0,
        (previousValue, element) => previousValue + element,
      )
      .asScore;

  bool? validate() {
    if (any((e) => e.isValid == null)) {
      return null;
    }
    return every((element) => element.isValid!);
  }
}
