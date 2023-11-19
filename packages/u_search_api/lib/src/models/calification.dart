// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:meta/meta.dart';
//
// import 'package:u_search_api/src/models/models.dart';
//
// /// {@template calification}
// /// A model representing a calification of an apply in a base.
// /// {@endtemplate}
// @immutable
// @JsonSerializable(
//   fieldRename: FieldRename.snake,
// )
// class Calification extends Equatable {
//   /// {@macro calification}
//   const Calification(
//     this.base, {
//     this.id,
//     this.score,
//     this.note,
//   });
//
//   /// Creates a copy of this calification but with the given fields replaced
//   /// with the new values.
//   Calification copyWith({
//     Base? base,
//     int? id,
//     double? score,
//     String? note,
//   }) {
//     return Calification(
//       base ?? this.base,
//       id: id ?? this.id,
//       score: score ?? this.score,
//       note: note ?? this.note,
//     );
//   }
//
//   /// The base of the calification.
//   final Base base;
//
//   /// The ID of the calification.
//   final int? id;
//
//   /// The score of the calification.
//   final double? score;
//
//   /// The note of the calification.
//   final String? note;
//
//   @override
//   List<Object?> get props => [base, id];
// }
