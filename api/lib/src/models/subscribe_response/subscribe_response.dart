import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:u_search_api/api.dart';

part 'subscribe_response.g.dart';

/// {@template subscribe_response}
/// A response from the subscribe endpoint.
/// {@endtemplate}
@JsonSerializable()
class SubscribeResponse extends Equatable {
  /// {@macro subscribe_response}
  const SubscribeResponse({
    required this.success,
    this.user,
  });

  /// Converts a `Map<String, dynamic>` to a [SubscribeResponse].
  factory SubscribeResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscribeResponseFromJson(json);

  /// Whether the subscription was successful.
  final bool success;

  /// The user in case already subscribed.
  final User? user;

  /// Converts a [SubscribeResponse] to a `Map<String, dynamic>`.
  Map<String, dynamic> toJson() => _$SubscribeResponseToJson(this);

  @override
  List<Object?> get props => throw UnimplementedError();
}
