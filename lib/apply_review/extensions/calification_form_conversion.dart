import 'package:data_repository/data_repository.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:u_search_flutter/apply_review/models/calification_form.dart';

extension CalificationFormConversion on CalificationForm {
  Calification get model => Calification(
        id: -1,
        subCriteria: SubCriteria(
          name: '',
          description: '',
          id: id,
          percent: percent,
          maxScore: score.maxScore ?? 5,
        ),
        score: double.tryParse(score.value) ?? 0,
        comment: comment.value,
      );

  // static CalificationForm fromModel(Calification calification) {
  //   return _(
  //     id: calification.subCriteria.id,
  //     percent: calification.subCriteria.percent,
  //     score: Score.pure(
  //       score: calification.score?.toString() ?? '',
  //       maxScore: calification.subCriteria.maxScore,
  //     ),
  //     comment: Comment.pure(value: calification.comment ?? ''),
  //   );
  // }
}
