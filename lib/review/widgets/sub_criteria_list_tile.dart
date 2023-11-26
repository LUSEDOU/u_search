import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:u_search_api/u_search_api.dart';

import 'package:u_search_flutter/review/review.dart';

class SubCriteriaListTile extends StatelessWidget {
  const SubCriteriaListTile({
    required this.subCriteria,
    required this.calification,
    super.key,
  });

  final SubCriteria subCriteria;
  final Calification calification;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Row(
                  children: [
                    SizedBox(
                      child: Text(
                        subCriteria.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          ToolTip(subCriteria.description),
                          const SizedBox(width: 16),
                          PercentBullet(
                            subCriteria.percent,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _ScoreBullet(
              calification.score,
              approved:
                  (calification.score ?? 0) >= (subCriteria.minScore ?? 0),
              maxScore: subCriteria.maxScore,
              readOnly: false,
              onChanged: (value) => context.read<ReviewBloc>().add(
                    ReviewScoreChanged(
                      subCriteria: subCriteria,
                      score: double.tryParse(value),
                    ),
                  ),
            ),
          ],
        ),
        _CommentField(
          initalComment: calification.comment,
          onChanged: (value) => context.read<ReviewBloc>().add(
                ReviewCommentChanged(subCriteria: subCriteria, comment: value),
              ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _CommentField extends StatelessWidget {
  const _CommentField({
    this.initalComment,
    this.onChanged,
  });

  final String? initalComment;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initalComment,
      // readOnly:
      // controller: controller,
      style: const TextStyle(),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Comment',
        isDense: true,
        isCollapsed: false,
      ),
      maxLines: 4,
      onChanged: onChanged,
    );
  }
}

class _ScoreBullet extends StatelessWidget {
  const _ScoreBullet(
    this.score, {
    this.approved = true,
    this.maxScore = 5,
    this.readOnly = true,
    this.onChanged,
  });

  final double? score;
  final double maxScore;
  final bool approved;
  final bool readOnly;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = score != null
        ? approved
            ? const Color(0xFF1DB954)
            : const Color(0xFFD32F2F)
        : Colors.grey.withOpacity(0.5);

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
            SizedBox(
              width: 32,
              child: _ScoreField(
                readOnly: readOnly,
                onChanged: onChanged,
                color: color,
                score: score,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '/ $maxScore',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreField extends StatelessWidget {
  const _ScoreField({
    this.readOnly = true,
    this.onChanged,
    this.color = Colors.black,
    this.score,
  });

  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final Color color;
  final double? score;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: const Key('reviewView_score_textFormField'),
      initialValue: score != null ? score!.toString() : null,
      readOnly: readOnly,
      textAlign: TextAlign.end,
      style: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.bold,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        isDense: true,
        counterText: '',
        hintText: '0.0',
      ),
      maxLength: 4,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      onChanged: onChanged,
      inputFormatters: [
        LengthLimitingTextInputFormatter(4),
        FilteringTextInputFormatter.allow(
          RegExp(r'^\d(?:\.\d{0,2})?$'),
        )
      ],
    );
  }
}
