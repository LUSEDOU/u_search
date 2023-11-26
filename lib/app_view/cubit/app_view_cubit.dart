import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_view_state.dart';

class AppViewCubit extends Cubit<AppViewState> {
  AppViewCubit() : super(const AppViewState());
}
