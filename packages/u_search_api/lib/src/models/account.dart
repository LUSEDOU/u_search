// import 'package:equatable/equatable.dart';
// import 'package:u_search_api/src/models/apply.dart';
// import 'package:u_search_api/src/models/email.dart';
// import 'package:u_search_api/src/models/password.dart';
//
// /// {@template account}
// /// Account model
// /// {@endtemplate}
// class Account extends Equatable {
//   /// {@macro account}
//   const Account({
//     this.id,
//     this.name,
//     this.email,
//     this.password,
//     this.applicant,
//     this.evaluator,
//   });
//
//   static const empty = Account();
//
//   /// The account id
//   final int? id;
//
//   /// The account name
//   final String? name;
//
//   /// The account email
//   final Email? email;
//
//   /// The account password
//   final Password? password;
//
//   /// The reference to the applicant
//   final Applicant? applicant;
//
//   /// The reference to the evaluator
//   final Evaluator? evaluator;
//
//   @override
//   List<Object?> get props => [id, name, email, password];
// }
//
// class Research extends Equatable {
//     Applicant applicant;
// }
//
// class Evaluator extends Equatable {
//     int? id;
//     List<Review>? reviews;
// }
//
// class Review extends Equatable {
//     Apply apply;
//     Evaluator? evaluator;
//     double? score;
//     int? id;
//     String? comment;
//     List<Calification>? califications;
// }
//
// class Calification extends Equatable {
//     int? id;
//     SubCriteria? subCriteria;
//     double? score;
//     String? judge;
// }
//
// class Contest extends Equatable {
//     int? id;
//     String? name;
//     String? description;
//     DateTime? startDate;
//     DateTime? endDate;
//     List<Criteria>? criterias;
// }
//
// class Criteria extends Equatable {
//     int? id;
//     String name;
//     String description;
//     double minScore;
//     double maxScore;
//     double percentage;
//     List<SubCriteria>? subCriterias;
// }
//
// class SubCriteria extends Equatable {
//     int? id;
//     String name;
//     String description;
//     double minScore;
//     double maxScore;
//     double percentage;
// }
