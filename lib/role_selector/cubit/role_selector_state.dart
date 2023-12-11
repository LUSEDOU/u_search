part of 'role_selector_cubit.dart';

enum RoleSelectorStatus { initial, loading, success, failure }

class RoleSelectorState extends Equatable {
  const RoleSelectorState({
    required this.role,
    this.status = RoleSelectorStatus.initial,
    this.type = RoleType.unknown,
    this.code = const Code.pure(),
  });

  final Role role;
  final RoleType type;
  final RoleSelectorStatus status;
  final Code code;

  RoleSelectorState copyWith({
    RoleSelectorStatus? status,
    Role? role,
    Code? code,
    RoleType? type,
  }) {
    return RoleSelectorState(
      status: status ?? this.status,
      role: role ?? this.role,
      code: code ?? this.code,
      type: type ?? this.type,
    );
  }

  @override
  List<Object> get props => [status, role, code, type];
}

extension RoleSelectorStateX on RoleSelectorState {
  bool get isInitial => status == RoleSelectorStatus.initial;
  bool get isLoading => status == RoleSelectorStatus.loading;
  bool get isSuccess => status == RoleSelectorStatus.success;
  bool get isFailure => status == RoleSelectorStatus.failure;
}

