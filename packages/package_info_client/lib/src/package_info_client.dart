import 'package:equatable/equatable.dart';

/// {@template package_info_client}
/// A client that provides package information.
/// {@endtemplate}
class PackageInfoClient extends Equatable {
  /// {@macro package_info_client}
  const PackageInfoClient({
    required this.appName,
    required this.packageName,
    required this.packageVersion,
  });

  final String appName;
  final String packageName;
  final String packageVersion;

  @override
  List<Object?> get props => [appName, packageName, packageVersion];
}
