import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

class SubCriteriaTile extends StatelessWidget {
  const SubCriteriaTile({
    required this.subCriteria,
    super.key,
  });

  final SubCriteria subCriteria;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
      builder: (context, state) {
        final calification =
            state.califications.getFromSubCriteria(subCriteria);

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      subCriteria.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${subCriteria.percent * 100}%',
                    ),
                  ],
                ),
              ],
            ),
            Text(
              subCriteria.description,
            ),
            ScoreField(
              id: subCriteria.id,
              score: calification?.score,
            ),
            CommentField(
              id: subCriteria.id,
              comment: calification?.comment,
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
