import 'package:application_repository/application_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_api/api.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required ApplicationRepository applicationRepository,
  })  : _applicationRepository = applicationRepository,
        super(const UserState());

  final ApplicationRepository _applicationRepository;

  Future<void> fetchUsers() async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final users = await _applicationRepository.fetchUsers();
      emit(state.copyWith(status: UserStatus.success, users: users));
    } catch (e, stackTrace) {
      emit(state.copyWith(status: UserStatus.failure));
      addError(e, stackTrace);
    }
  }

  Future<void> addUser(User user) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final newUser = await _applicationRepository.inviteUser(user);
      emit(
        state.copyWith(
          status: UserStatus.success,
          users: [...state.users, newUser],
        ),
      );
    } catch (e, stackTrace) {
      emit(state.copyWith(status: UserStatus.failure));
      addError(e, stackTrace);
    }
  }

  Future<void> updateUser(User user) async {
    emit(state.copyWith(status: UserStatus.loading));
    try {
      final users = [...state.users];
      final index = users.indexWhere((u) => u.id == user.id);
      if (index == -1) {
        throw Exception('User not found');
      }

      await _applicationRepository.updateUser(user);
      users[index] = user;

      emit(state.copyWith(status: UserStatus.success, users: users));
    } catch (e, stackTrace) {
      emit(state.copyWith(status: UserStatus.failure));
      addError(e, stackTrace);
    }
  }
}
