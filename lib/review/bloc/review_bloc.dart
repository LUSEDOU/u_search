import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/u_search_api.dart';

part 'review_state.dart';
part 'review_event.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc({
    required Apply apply,
    required ReviewRepository reviewRepository,
  })  : _reviewRepository = reviewRepository,
        super(
          ReviewState(
            apply: apply,
            initialReview: apply.review,
            califications: apply.review?.califications ?? [],
          ),
        ) {
    on<ReviewScoreChanged>(_onScoreChangedvent);
    on<ReviewCommentChanged>(_onCommentChangedEvent);
    on<ReviewSubmitted>(_onSubmitted);
  }

  final ReviewRepository _reviewRepository;

  void _onScoreChangedvent(
    ReviewScoreChanged event,
    Emitter<ReviewState> emit,
  ) {
    final calification = state.calificationFrom(event.subCriteria);
    final newCalification = calification.copyWith(score: event.score);

    List<Calification> califications = state.califications.toList();
    califications.remove(calification);
    califications.add(newCalification);

    emit(
      state.copyWith(
        califications: califications,
      ),
    );
  }

  void _onCommentChangedEvent(
    ReviewCommentChanged event,
    Emitter<ReviewState> emit,
  ) {
    final calification = state.calificationFrom(event.subCriteria);
    final newCalification = calification.copyWith(comment: event.comment);

    List<Calification> califications = state.califications.toList();
    califications.remove(calification);
    califications.add(newCalification);

    emit(
      state.copyWith(
        califications: califications,
      ),
    );
  }

  Future<void> _onSubmitted(
    ReviewSubmitted event,
    Emitter<ReviewState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ReviewStatus.loading,
      ),
    );

    final review = (state.initialReview ?? Review(apply: state.apply)).copyWith(
      califications: state.califications,
    );

    final savedReview = await _reviewRepository.saveReview(review);

    emit(
      state.copyWith(
        status: ReviewStatus.success,
        initialReview: savedReview,
      ),
    );
  }
}

class ReviewRepository {
  const ReviewRepository();

  Future<Review> saveReview(Review review) async {
    return review;
  }
}
