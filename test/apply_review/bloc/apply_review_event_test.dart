import 'package:flutter_test/flutter_test.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

void main() {
  group('ApplyReviewEvent', () {
    group('ApplyReviewScoreChanged', () {
      test('supports value equality', () {
        expect(
          const ApplyReviewScoreChanged(score: '1', id: 1),
          equals(
            const ApplyReviewScoreChanged(score: '1', id: 1),
          ),
        );
      });

      test('supports value equality', () {
        expect(
          const ApplyReviewScoreChanged(score: '1', id: 1),
          isNot(
            equals(
              const ApplyReviewScoreChanged(score: '2', id: 1),
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          const ApplyReviewScoreChanged(score: '1', id: 1).props,
          equals([1, '1']),
        );
      });
    });

    group('ApplyReviewCommentChanged', () {
      test('supports value equality', () {
        expect(
          const ApplyReviewCommentChanged(comment: '1', id: 1),
          equals(
            const ApplyReviewCommentChanged(comment: '1', id: 1),
          ),
        );
      });

      test('supports value equality', () {
        expect(
          const ApplyReviewCommentChanged(comment: '1', id: 1),
          isNot(
            equals(
              const ApplyReviewCommentChanged(comment: '2', id: 1),
            ),
          ),
        );
      });

      test('props are correct', () {
        expect(
          const ApplyReviewCommentChanged(comment: '1', id: 1).props,
          equals([1, '1']),
        );
      });
    });


    // group('ApplyReviewSubmitted', () {
    //   test('supports value equality', () {
    //     expect(
    //       const ApplyReviewSubmitted(id: 1),
    //       equals(
    //         const ApplyReviewSubmitted(id: 1),
    //       ),
    //     );
    //   });
    //
    //   test('supports value equality', () {
    //     expect(
    //       const ApplyReviewSubmitted(id: 1),
    //       isNot(
    //         equals(
    //           const ApplyReviewSubmitted(id: 2),
    //         ),
    //       ),
    //     );
    //   });
    //
    //   test('props are correct', () {
    //     expect(
    //       const ApplyReviewSubmitted(id: 1).props,
    //       equals([1]),
    //     );
    //   });
    // });
  });
}
