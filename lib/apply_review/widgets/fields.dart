import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

class CommentField extends StatelessWidget {
  const CommentField({
    required this.id,
    this.comment,
    super.key,
  });

  final int id;
  final Comment? comment;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
      builder: (context, state) {
        return TextFormField(
          key: Key('applyReviewView_comment_textFormField_$id'),
          initialValue: comment?.value,
          readOnly: state.isNew,
          onChanged: (value) => context.read<ApplyReviewBloc>().add(
                ApplyReviewCommentChanged(
                  id: id,
                  comment: value,
                ),
              ),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Comment',
            helperText: 'Write a comment about this criteria',
            errorText: comment?.displayError != null
                ? (comment?.displayError as CommentValidationError).message
                : null,
            isDense: true,
            isCollapsed: false,
          ),
          maxLines: 2,
        );
      },
    );
  }
}

class ScoreField extends StatelessWidget {
  const ScoreField({
    required this.id,
    this.score,
    super.key,
  });

  final int id;
  final Score? score;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
      builder: (context, state) {
        return TextFormField(
          key: Key('applyReviewView_score_textFormField_$id'),
          initialValue: score?.value,
          readOnly: state.isNew,
          onChanged: (value) => context.read<ApplyReviewBloc>().add(
                ApplyReviewScoreChanged(
                  id: id,
                  score: value,
                ),
              ),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Score',
            isDense: true,
            isCollapsed: false,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
              RegExp(r'^\d(?:\.\d{0,2})?$'),
            )
          ],
        );
      },
    );
  }
}
