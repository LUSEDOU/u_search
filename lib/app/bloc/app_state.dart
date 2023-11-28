part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

enum UserType {
  user('Applicant'),
  evaluator('Evaluator'),
  admin('Admin'),
  unknown('Unknown');

  const UserType(
    this.name,
  );

  final String name;

  static List<UserType> get permitted => [
        user,
        evaluator,
      ];
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.unauthenticated,
    this.type = UserType.unknown,
    this.user = User.empty,
  });

  final AppStatus status;
  final UserType type;
  final User user;

  AppState copyWith({
    AppStatus? status,
    UserType? type,
    User? user,
  }) {
    return AppState(
      status: status ?? this.status,
      type: type ?? this.type,
      user: user ?? this.user,
    );
  }

  bool get isUnauthenticated => status == AppStatus.unauthenticated;
  bool get isAuthenticated => status == AppStatus.authenticated;
  bool get isUnknown => type == UserType.unknown;
  bool get isEvaluator => type == UserType.evaluator;
  bool get isApplicant => type == UserType.user;
  int? get id {
    switch (type) {
      case UserType.evaluator:
        return user.evaluatorId;
      case UserType.user:
        return user.applicantId;
      default:
        return null;
    }
  }

  @override
  List<Object> get props => [status, type, user];
}
