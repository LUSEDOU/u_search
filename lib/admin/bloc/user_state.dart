part of 'user_cubit.dart';

enum UserStatus { initial, loading, success, failure }

class UserState extends Equatable {
  const UserState({
    this.status = UserStatus.initial,
    this.users = const <User>[],
  });

  final UserStatus status;
  final List<User> users;

  @override
  List<Object?> get props => [status, users];

  UserState copyWith({
    UserStatus? status,
    List<User>? users,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
