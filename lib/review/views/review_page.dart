// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:u_search_flutter/review/review.dart';
//
// class ReviewPage extends StatelessWidget {
//   const ReviewPage({
//     required this.id,
//     super.key,
//   });
//
//   final int id;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         return ReviewCubit(
//           review: Review(
//             id: id,
//           ),
//           reviewRepository: context.read<ReviewRepository>(),
//         )..fetchReview();
//       },
//       child: const ReviewView(),
//     );
//   }
// }
//
// class ReviewView extends StatefulWidget {
//   const ReviewView({super.key});
//
//   @override
//   State<ReviewView> createState() => _ReviewViewState();
// }
//
// class _ReviewViewState extends State<ReviewView> {
//   @override
//   Widget build(BuildContext context) {
//     final review = context.select((ReviewCubit cubit) => cubit.state.review);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Review'),
//       ),
//       body: CupertinoScrollbar(
//         child: ListView(
//           children: [
//             for (final criteria in review.contest.criterias)
//               CriteriaWidget(
//                 criteria: criteria,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CriteriaWidget extends StatelessWidget {
//   const CriteriaWidget({
//     required this.criteria,
//     super.key,
//   });
//   final Criteria criteria;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final textTheme = theme.textTheme;
//     final score = context.select(
//       (ReviewCubit cubit) => cubit.state.scoreFrom(criteria),
//     );
//
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               criteria.name,
//               style: textTheme.headlineLarge,
//             ),
//             Container(
//               decoration: ShapeDecoration(
//                 shape: const StadiumBorder(),
//                 color: score >= criteria.minScore
//                     ? Colors.green
//                     : Colors.red,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   '$score',
//                   style: textTheme.headlineLarge,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         CupertinoScrollbar(
//           child: ListView(
//             children: [
//               for (final subCriteria in criteria.subCriterias)
//                 SubCriteriaWidget(
//                   subCriteria: subCriteria,
//                   calification: context.select((ReviewCubit cubit) =>
//                       cubit.state.calificationFrom(subCriteria)),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class SubCriteriaWidget extends StatelessWidget {
//   const SubCriteriaWidget({
//     required this.subCriteria,
//     required this.calification,
//     super.key,
//   });
//
//   final SubCriteria subCriteria;
//   final Calification calification;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(subCriteria.name),
//             Container(
//               decoration: ShapeDecoration(
//                 shape: const StadiumBorder(),
//                 color: calification.score >= subCriteria.minScore
//                     ? Colors.green
//                     : Colors.red,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text('${calification.score}'),
//               ),
//             ),
//           ],
//         ),
//         Text(calification.comment),
//       ],
//     );
//   }
// }
