import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:u_search_api/u_search_api.dart';

import 'package:u_search_flutter/review/review.dart';

class CriteriaListTile extends StatelessWidget {
  const CriteriaListTile({
    required this.criteria,
    super.key,
  });
  final Criteria criteria;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final score = context.select(
      (ReviewBloc bloc) => bloc.state.scoreFrom(criteria),
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  criteria.name,
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(width: 8),
                ToolTip(criteria.description),
                const SizedBox(width: 16),
                PercentBullet(
                  criteria.percent,
                ),
              ],
            ),
            _ScoreBullet(
              context.select(
                (ReviewBloc bloc) => bloc.state.scoreFrom(criteria),
              ),
              approved: score >= (criteria.minScore ?? 0),
              maxScore: criteria.maxScore,
            ),
          ],
        ),
        Column(
          children: [
            for (final subCriteria in criteria.subCriterias)
              SubCriteriaListTile(
                subCriteria: subCriteria,
                calification: context.select(
                  (ReviewBloc bloc) => bloc.state.calificationFrom(subCriteria),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _ScoreBullet extends StatelessWidget {
  const _ScoreBullet(
    this.score, {
    this.approved = true,
    this.maxScore = 5,
    // this.readOnly = true,
    // this.onChanged,
  });

  final double score;
  final double maxScore;
  final bool approved;
  // final bool readOnly;
  // final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = approved ? const Color(0xFF1DB954) : const Color(0xFFD32F2F);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: color.withOpacity(0.1),
        border: Border.all(
          width: 3,
          color: color,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        child: Row(
          children: [
            Text(
              '$score / $maxScore',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
