import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_api/u_search_api.dart';
import 'package:u_search_flutter/review/review.dart';

class ReviewPage2 extends StatelessWidget {
  const ReviewPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final apply = Apply.fromJson(
      {
        'id': 1,
        'contest': {
          'id': 1,
          'name': 'Contest 1',
          'description': 'Contest 1 description',
          'criterias': [
            {
              'id': 1,
              'name': 'Criteria 1',
              'description': 'Criteria 1 description',
              'subCriterias': [
                {'id': 1, 'name': 'SubCriteria 1'},
                {'id': 2, 'name': 'SubCriteria 2'},
                {'id': 3, 'name': 'SubCriteria 3'},
              ]
            },
            {
              'id': 2,
              'name': 'Criteria 2',
              'description': 'Criteria 2 description',
              'subCriterias': [
                {'id': 4, 'name': 'SubCriteria 4'},
                {'id': 5, 'name': 'SubCriteria 5'},
                {'id': 6, 'name': 'SubCriteria 6'},
              ]
            },
            {
              'id': 3,
              'name': 'Criteria 3',
              'description': 'Criteria 3 description',
              'subCriterias': [
                {'id': 7, 'name': 'SubCriteria 7'},
                {'id': 8, 'name': 'SubCriteria 8'},
                {'id': 9, 'name': 'SubCriteria 9'},
              ]
            },
          ],
        },
        'review': {
            'id': 1,
        }
      },
    );

    return BlocProvider(
      create: (_) => ReviewCubit(apply: apply),
      child: const ReviewView2(),
    );
  }
}

class ReviewView2 extends StatefulWidget {
  const ReviewView2({super.key});

  @override
  State<ReviewView2> createState() => _ReviewView2State();
}

class _ReviewView2State extends State<ReviewView2> {
  @override
  Widget build(BuildContext context) {
    final review = context.select((ReviewCubit cubit) => cubit.state.review);

    return Scaffold(
      appBar: AppBar(
        title: Text('Review ${review.id}'),
      ),
    );
  }
}

class CriteriaWidget extends StatelessWidget {
  const CriteriaWidget({
    required this.criteria,
    super.key,
  });
  final Criteria criteria;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    // final score = context.select(
    //   (ReviewCubit cubit) => cubit.state.scoreFrom(criteria),
    // );
    final score = 5;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              criteria.name,
              style: textTheme.headlineLarge,
            ),
            Container(
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                // color: score >= criteria.minScore
                //     ? Colors.green
                //     : Colors.red,
                color: score >= 5
                    ? Colors.green
                    : Colors.red,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$score',
                  style: textTheme.headlineLarge,
                ),
              ),
            ),
          ],
        ),
        CupertinoScrollbar(
          child: ListView(
            children: [
              for (final subCriteria in criteria.subCriterias)
                SubCriteriaWidget(
                  subCriteria: subCriteria,
                  calification: context.select((ReviewCubit cubit) =>
                      cubit.state.calificationFrom(subCriteria)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
