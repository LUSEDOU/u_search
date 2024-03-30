part of 'firebase_authentication_client.dart';

/// {@template firebase_authentication_failure}
/// Exception from the firebase_authentication client.
/// {@endtemplate}
abstract class FirebaseAuthenticationFailure with EquatableMixin implements Exception {
  /// {@macro firebase_authentication_failure}
  const FirebaseAuthenticationFailure(this.error);

  /// The error which was caught.
  final Object error;

  @override
  List<Object> get props => [error];
}
