import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'applies_overview_event.dart';
part 'applies_overview_state.dart';

class AppliesOverviewBloc
    extends Bloc<AppliesOverviewEvent, AppliesOverviewState> {
  AppliesOverviewBloc() : super(const AppliesOverviewState()) {
    on<AppliesOverviewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
