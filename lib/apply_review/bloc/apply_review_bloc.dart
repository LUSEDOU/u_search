import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apply_review_event.dart';
part 'apply_review_state.dart';

class ApplyReviewBloc extends Bloc<ApplyReviewEvent, ApplyReviewState> {
  ApplyReviewBloc() : super(const ApplyReviewState()) {
    on<ApplyReviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
