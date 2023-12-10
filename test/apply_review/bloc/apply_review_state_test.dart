import 'package:data_repository/data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

void main() {
  group('ApplyReviewState', () {
    const mockApply = Apply(
      contest: Contest(
        id: 0,
        name: '',
        description: '',
        criterias: [],
      ),
      url: '',
    );

    const mockReview = Review(
      id: 0,
      califications: [],
      apply: mockApply,
    );

    ApplyReviewState createSubject({
      ApplyReviewStatus status = ApplyReviewStatus.initial,
      Apply apply = mockApply,
      Review? initialReview,
      List<CalificationForm> califications = const [],
      bool? isValid,
    }) {
      return ApplyReviewState(
        status: status,
        apply: apply,
        califications: califications,
        isValid: isValid,
        initialReview: initialReview,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(
          createSubject(),
        ),
      );
    });

    test('supports deep value equality', () {
      final calification = CalificationForm.pure(
        id: 0,
      );

      expect(
        createSubject(
          apply: mockApply,
          initialReview: mockReview,
          califications: [
            calification.dirty(score: '1'),
          ],
        ),
        isNot(
          equals(
            createSubject(
              apply: mockApply,
              initialReview: mockReview,
              califications: [
                calification.dirty(score: '2'),
              ],
            ),
          ),
        ),
      );
    });

    test('support value equality in list order', () {
      final calification = CalificationForm.pure(
        id: 0,
      );

      expect(
        createSubject(
          apply: mockApply,
          initialReview: mockReview,
          califications: [
            calification.dirty(score: '1'),
            calification.dirty(score: '2'),
          ],
        ),
        isNot(
          equals(
            createSubject(
              apply: mockApply,
              initialReview: mockReview,
              califications: [
                calification.dirty(score: '2'),
                calification.dirty(score: '1'),
              ],
            ),
          ),
        ),
      );
    });

    test('props are correct', () {
      final calification = CalificationForm.pure(
        id: 0,
      );

      expect(
        createSubject(
          apply: mockApply,
          initialReview: mockReview,
          califications: [
            calification.dirty(score: '1'),
          ],
        ).props,
        equals([
          mockApply,
          mockReview,
          ApplyReviewStatus.initial,
          [calification.dirty(score: '1')],
        ]),
      );
    });

    test('isNew returns true when a new Review is created', () {
      expect(
        createSubject(
          initialReview: null,
        ).isNew,
        isTrue,
      );
    });

    test('isNew returns false when a Review is edited', () {
      expect(
        createSubject(
          initialReview: mockReview,
        ).isNew,
        isFalse,
      );
    });

    group('copyWith', () {
      test('returns same object when no params are passed', () {
        final subject = createSubject();
        expect(
          subject.copyWith(),
          equals(subject),
        );
      });
      test('returns object with updated params', () {
        final subject = createSubject();
        expect(
          subject.copyWith(
            status: ApplyReviewStatus.success,
          ),
          equals(
            createSubject(
              status: ApplyReviewStatus.success,
            ),
          ),
        );
      });
    });

    group('extension ApplyReviewStateX', () {
      test('isLoading returns true when status is loading', () {
        expect(
          createSubject(
            status: ApplyReviewStatus.loading,
          ).isLoading,
          isTrue,
        );
      });
      test('isLoading returns false when status is not loading', () {
        expect(
          createSubject(
            status: ApplyReviewStatus.initial,
          ).isLoading,
          isFalse,
        );
      });
      test('isSuccess returns true when status is success', () {
        expect(
          createSubject(
            status: ApplyReviewStatus.success,
          ).isSuccess,
          isTrue,
        );
      });
      test('isSuccess returns false when status is not success', () {
        expect(
          createSubject(
            status: ApplyReviewStatus.initial,
          ).isSuccess,
          isFalse,
        );
      });
    });
  });
}
