part of '{{name.snakeCase()}}_bloc.dart';

sealed class {{name.pascalCase()}}Event extends Equatable {
  const {{name.pascalCase()}}Event();
}

final class {{name.pascalCase()}}Requested extends {{name.pascalCase()}}Event {
  const {{name.pascalCase()}}Requested();

  @override
  List<Object> get props => [];
}
