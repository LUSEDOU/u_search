import 'package:bloc_test/bloc_test.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

class MockDataRepository extends Mock implements DataRepository {}

class FakeApply extends Fake implements Apply {}

void main() {
  Apply buildApply({
    List<Criteria> criterias = const [],
    Review? review,
  }) {
    return Apply(
      contest: Contest(
        id: 1,
        name: '',
        description: '',
        criterias: criterias,
      ),
      url: '',
      review: review,
    );
  }

  SubCriteria buildSubCriteria({
    int id = 1,
    double maxScore = 5,
    percent = 1,
  }) {
    return SubCriteria(
      id: id,
      name: '',
      description: '',
      maxScore: maxScore,
      percent: percent,
    );
  }

  Criteria buildCriteria({
    int id = 1,
    double maxScore = 5,
    percent = 1,
    List<SubCriteria> subCriterias = const [],
  }) {
    return Criteria(
      id: id,
      name: '',
      description: '',
      maxScore: maxScore,
      percent: percent,
      subCriterias: subCriterias,
    );
  }

  Calification buildCalification({
    int id = 1,
    double score = 5,
    String comment = '',
    double percent = 1,
    double maxScore = 5,
  }) {
    return Calification(
      subCriteria: SubCriteria(
        percent: percent,
        id: id,
        maxScore: maxScore,
      ),
      id: id,
      score: score,
      comment: comment,
    );
  }

  final mockSubCriterias = [
    buildSubCriteria(id: 1, percent: 0.5),
    buildSubCriteria(id: 2, percent: 0.2),
    buildSubCriteria(id: 3, percent: 0.3),
    buildSubCriteria(id: 4, percent: 0.5),
    buildSubCriteria(id: 5, percent: 0.5),
  ];

  final mockCriterias = [
    buildCriteria(
      id: 1,
      percent: 0.6,
      subCriterias: mockSubCriterias.sublist(0, 3),
    ),
    buildCriteria(
      id: 2,
      percent: 0.4,
      subCriterias: mockSubCriterias.sublist(3, 5),
    ),
  ];

  final mockCalifications = [
    buildCalification(id: 1, percent: 0.5, score: 5),
    buildCalification(id: 2, percent: 0.2, score: 3),
    buildCalification(id: 3, percent: 0.3, score: 2),
    buildCalification(id: 4, percent: 0.5, score: 5),
    buildCalification(id: 5, percent: 0.5, score: 3),
  ];

  final mockReview = Review(
    id: 1,
    califications: mockCalifications,
  );

  final mockApply = buildApply(criterias: mockCriterias);

  group('ApplyReviewBloc', () {
    late DataRepository dataRepository;

    setUpAll(() {
      registerFallbackValue(FakeApply());
    });

    setUp(() {
      dataRepository = MockDataRepository();
    });

    ApplyReviewBloc buildBloc({
      required Apply apply,
    }) {
      return ApplyReviewBloc(
        dataRepository: dataRepository,
        apply: apply,
      );
    }

    group('constructor', () {
      test('works properly', () {
        expect(buildBloc(apply: buildApply()), isInstanceOf<ApplyReviewBloc>());
      });

      group('without review', () {
        late Apply apply;

        setUp(() {
          apply = mockApply;
        });

        test('initial state is correct', () {
          final state = buildBloc(apply: apply).state;

          expect(
            state.status,
            ApplyReviewStatus.initial,
          );
          expect(
            state.apply,
            apply,
          );
          expect(
            state.califications,
            apply.contest.criterias
                .expand((criteria) => criteria.subCriterias)
                .map(
                  (subcriteria) => CalificationForm.pure(
                    id: subcriteria.id,
                    maxScore: subcriteria.maxScore,
                    percent: subcriteria.percent,
                  ),
                )
                .toList(),
          );
          expect(
            state.isValid,
            null,
          );
          expect(
            state.initialReview,
            null,
          );
        });
      });

      group('with review', () {
        late Apply apply;

        setUp(() {
          apply = buildApply(
            criterias: mockCriterias,
            review: mockReview,
          );
        });

        test('initial state is correct', () {
          final state = buildBloc(apply: apply).state;

          expect(
            state.status,
            ApplyReviewStatus.initial,
          );
          expect(
            state.apply,
            apply,
          );
          expect(
            state.califications,
            mockReview.califications.map(CalificationForm.fromModel).toList(),
          );
          expect(state.isValid, true);
          expect(
            state.initialReview,
            mockReview,
          );
        });
      });
    });

    group('ApplyReviewCommentChanged', () {
      late Apply apply;
      late List<CalificationForm> califications;

      setUp(() {
        apply = mockApply;
        califications = apply.contest.califications;
      });

      blocTest<ApplyReviewBloc, ApplyReviewState>(
        'emits [ApplyReviewState] with updated califications',
        build: () => buildBloc(apply: apply),
        act: (bloc) => bloc.add(
          const ApplyReviewCommentChanged(
            id: 1,
            comment: 'test',
          ),
        ),
        expect: () => [
          ApplyReviewState(
            apply: apply,
            califications: califications
              ..removeWhere((calification) => calification.id == 1)
              ..add(
                CalificationForm.pure(id: 1, percent: 0.5).dirty(
                  score: '5',
                  comment: 'test',
                ),
              ),
          ),
        ],
      );
    });
  });
}
