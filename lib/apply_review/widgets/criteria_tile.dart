import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

class CriteriaTile extends StatelessWidget {
  const CriteriaTile({
    required this.criteria,
    super.key,
  });

  final Criteria criteria;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final score = state.califications.scoreFrom(criteria);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      criteria.name,
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      '${(criteria.percent * 100).truncate()}%',
                    ),
                  ],
                ),
                Text(
                  '$score',
                )
              ],
            ),
            Text(
              criteria.description,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: [
                  for (final subCriteria in criteria.subCriterias)
                    SubCriteriaTile(subCriteria: subCriteria),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
