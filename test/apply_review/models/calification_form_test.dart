import 'package:data_repository/data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/factory.dart';

void main() {
  SubCriteria buildSubcriteria({
    int id = 0,
    double percent = 1,
  }) =>
      SubCriteria(
        id: id,
        name: '',
        description: '',
        maxScore: 4,
        percent: percent,
      );

  Criteria buildCriteria({
    int id = 0,
    int subCriteriaId = 0,
    int length = 2,
    double percent = 1,
  }) =>
      Criteria(
        id: id,
        name: '',
        description: '',
        subCriterias: List.generate(
          length,
          (index) => buildSubcriteria(
            id: index + subCriteriaId,
            percent: 1 / length,
          ),
        ),
        percent: percent,
      );

  List<Criteria> buildCriterias() => [
        buildCriteria(
          id: 0,
          subCriteriaId: 0,
          length: 2,
          percent: 0.5,
        ),
        buildCriteria(
          id: 1,
          subCriteriaId: 2,
          length: 4,
          percent: 0.2,
        ),
        buildCriteria(
          id: 2,
          subCriteriaId: 6,
          length: 3,
          percent: 0.3,
        ),
      ];

  Contest buildContest() => Contest(
        id: 0,
        name: '',
        description: '',
        criterias: buildCriterias(),
      );

  group(
    'Pure',
    () {
      late SubCriteria subcriteria;

      setUp(() {
        subcriteria = buildSubcriteria(id: 1, percent: 0.5);
      });

      test('returns empty scores and comment', () {
        final calificationForm = CalificationForm.pure(
          id: subcriteria.id,
        );

        expect(calificationForm.score.value, '');
        expect(calificationForm.comment.value, '');
      });

      test('return score with the maxScore', () {
        final calificationForm = CalificationForm.pure(
          id: subcriteria.id,
          maxScore: subcriteria.maxScore,
        );

        expect(
          calificationForm.score.maxScore,
          subcriteria.maxScore,
        );
      });

      test('return score with the percent', () {
        final calificationForm = CalificationForm.pure(
          id: subcriteria.id,
          percent: subcriteria.percent,
        );

        expect(
          calificationForm.percent,
          subcriteria.percent,
        );
      });
    },
  );

  group('dirty', () {
    late final SubCriteria subcriteria;

    setUp(() {
      subcriteria = buildSubcriteria(id: 1, percent: 0.5);
    });

    test('returns a CalificationForm with the given score', () {
      final calification = CalificationForm.pure(id: subcriteria.id);

      final calificationForm = calification.dirty(score: '5');

      expect(calificationForm.score.value, '5');
    });
  });

  group('fromModel', () {
    late final Calification calification;

    setUp(() {
      calification = Calification(
        subCriteria: buildSubcriteria(id: 1, percent: 0.5),
        score: 3.33,
        comment: 'comment',
      );
    });

    test('returns a CalificationForm with the data', () {
      final calificationForm = CalificationForm.fromModel(calification);

      expect(
        calificationForm.score.value,
        calification.score!.toDouble().toString(),
      );
      expect(
        calificationForm.comment.value,
        calification.comment,
      );
      expect(
        calificationForm.id,
        calification.subCriteria.id,
      );
      expect(
        calificationForm.percent,
        calification.subCriteria.percent,
      );
      expect(
        calificationForm.isValid,
        true,
      );
      expect(
        calificationForm.score.maxScore,
        calification.subCriteria.maxScore,
      );
    });
  });

  group('model', () {
    late CalificationForm calificationForm;
    setUp(() {
      calificationForm = CalificationForm.pure(
        id: 0,
        maxScore: 5,
        percent: 0.5,
      );
    });

    group('Pure', () {
      test('returns a Calification with the data', () {
        final calification = calificationForm.model;

        expect(
          calification.subCriteria.id,
          calificationForm.id,
        );
        expect(
          calification.score,
          double.tryParse(calificationForm.score.value),
        );
        expect(
          calification.comment,
          calificationForm.comment.value,
        );
      });
    });

    group('Dirty', () {
      setUp(() {
        calificationForm = calificationForm.dirty(
          score: '3.33',
          comment: 'comment',
        );
      });

      test('returns a Calification with the data', () {
        final calification = calificationForm.model;

        expect(
          calification.subCriteria.id,
          calificationForm.id,
        );
        expect(
          calification.score,
          double.tryParse(calificationForm.score.value),
        );
        expect(
          calification.comment,
          calificationForm.comment.value,
        );
      });
    });

    group('fromModel', () {
      late Calification calification;

      setUp(() {
        calification = Calification(
          subCriteria: buildSubcriteria(id: 1, percent: 0.5),
          score: 3.33,
          comment: 'comment',
        );

        calificationForm = CalificationForm.fromModel(calification);
      });

      test('returns a CalificationForm with the data', () {
        final calificationModel = calificationForm.model;

        expect(
          calificationModel.score,
          calification.score,
        );
        expect(
          calificationModel.subCriteria.percent,
          calification.subCriteria.percent,
        );
        expect(
          calificationModel.subCriteria.maxScore,
          calification.subCriteria.maxScore,
        );
        expect(
          calificationModel.subCriteria.id,
          calification.subCriteria.id,
        );
        expect(
          calificationModel.comment,
          calification.comment,
        );
      });

      test('returns the same CalificationForm', () {
        expect(
          calificationForm.model,
          calification,
        );
      });
    });
  });
}
