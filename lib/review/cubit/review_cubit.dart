import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/u_search_api.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit({
    required Apply apply,
    ReviewRepository? reviewRepository,
  })  : _reviewRepository = reviewRepository ?? const ReviewRepository(),
        _review = apply,
        super(ReviewState(apply: apply));

  final ReviewRepository _reviewRepository;
  final Apply _review;

  Future<void> fetchReview() async {
    emit(state.copyWith(status: ReviewStatus.loading));
    try {
      final apply = await _reviewRepository.get(_review.id);
      emit(
        state.copyWith(apply: apply, status: ReviewStatus.success),
      );
    } on Exception {
      emit(state.copyWith(status: ReviewStatus.failure));
    }
  }
}

class ReviewRepository {
  const ReviewRepository();

  Future<Apply> get(int? id) async {
      return Apply.fromJson({
        'id': 1,
        'contest': {
          'id': 1,
          'criterias': [
            {
              'id': 1,
              'name': 'Criteria 1',
              'subCriterias': [
                {'id': 1, 'name': 'SubCriteria 1'},
                {'id': 2, 'name': 'SubCriteria 2'},
                {'id': 3, 'name': 'SubCriteria 3'},
              ]
            },
            {
              'id': 2,
              'name': 'Criteria 2',
              'subCriterias': [
                {'id': 4, 'name': 'SubCriteria 4'},
                {'id': 5, 'name': 'SubCriteria 5'},
                {'id': 6, 'name': 'SubCriteria 6'},
              ]
            },
            {
              'id': 3,
              'name': 'Criteria 3',
              'subCriterias': [
                {'id': 7, 'name': 'SubCriteria 7'},
                {'id': 8, 'name': 'SubCriteria 8'},
                {'id': 9, 'name': 'SubCriteria 9'},
              ]
            },
          ]
        },
      });
  }
}
