import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'apply_event.dart';
part 'apply_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState> {
  ApplyBloc() : super(const ApplyState()) {
    on<ApplyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
