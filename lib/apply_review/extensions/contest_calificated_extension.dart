import 'package:data_repository/data_repository.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

extension ContestCalificatedExtension on Contest {
  List<CalificationForm> get califications => criterias
      .expand((element) => element.subCriterias)
      .map(CalificationForm.fromSubCriteria)
      .toList();
}
