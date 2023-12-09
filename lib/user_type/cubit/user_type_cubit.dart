import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:data_repository/data_repository.dart';

part 'user_type_state.dart';

class UserTypeCubit extends Cubit<UserTypeState> {
  UserTypeCubit({
    required DataRepository dataRepository,
  })  : _dataRepository = dataRepository,
        super(const UserTypeState());

  final DataRepository _dataRepository;
}
