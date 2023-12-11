import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:u_search_flutter/utils/models_extensions.dart';

part 'role_selector_state.dart';

class RoleSelectorCubit extends Cubit<RoleSelectorState> {
  RoleSelectorCubit({
    required DataRepository dataRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _dataRepository = dataRepository,
        _authenticationRepository = authenticationRepository,
        super(
          RoleSelectorState(
            role: dataRepository.currentRole,
          ),
        );

  final DataRepository _dataRepository;
  final AuthenticationRepository _authenticationRepository;

  void roleTypeChanged(RoleType? type) {
    emit(
      state.copyWith(type: type ?? RoleType.unknown),
    );
  }

  void codeChanged(String value) {
    emit(
      state.copyWith(
        code: Code.dirty(value),
      ),
    );
  }

  Future<void> roleTypeSubmitted() async {
    if (!state.code.isValid) return;
    emit(
      state.copyWith(
        status: RoleSelectorStatus.loading,
      ),
    );
    try {
      final isValid = await _dataRepository.validateCode(
        state.code.value,
        state.type.id,
      );

      if (!isValid) {
        emit(state.copyWith(status: RoleSelectorStatus.failure));
        return;
      }

      var role = state.role.copyWith(type: state.type);

      if (_authenticationRepository.currentUser.isNotEmpty) {
        role = await _dataRepository.addRoleToUser(
          role,
          user: _authenticationRepository.currentUser.toModel(),
        );
      } else {
        _dataRepository.updateRole(role);
      }
      emit(
        state.copyWith(
          role: role,
          status: RoleSelectorStatus.success,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: RoleSelectorStatus.failure,
        ),
      );
    }
  }
}
