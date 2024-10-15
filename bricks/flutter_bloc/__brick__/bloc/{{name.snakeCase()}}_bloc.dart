import 'package:application_repository/application_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:u_search_api/client.dart';

import 'package:u_search_flutter/{{name.snakeCase()}}/{{name.snakeCase()}}.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

part '{{name.snakeCase()}}_event.dart';
part '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  {{name.pascalCase()}}Bloc({
    required ApplicationRepository applicationRepository,
  })  : _applicationRepository = applicationRepository,
        super(const {{name.pascalCase()}}State()) {
    on<{{name.pascalCase()}}Requested>(_onRequested);
  }

  final ApplicationRepository _applicationRepository;

  Future<void> _onRequested(
    {{name.pascalCase()}}Requested event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(state.copyWith(status: {{name.pascalCase()}}Status.loading));
    try {
      final calification = CalificationNode.fromReview(review);
      emit(
        state.copyWith(
          status: {{name.pascalCase()}}Status.initial,
        ),
      );
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(status: {{name.pascalCase()}}Status.failure));
    }
  }
}
