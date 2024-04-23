import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_api/client.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

class CriteriumTile extends StatelessWidget {
  const CriteriumTile({
    required this.node,
    super.key,
  });

  final CalificationNode node;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(node.name),
            BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
              buildWhen: (previous, current) =>
                  previous.calification.getFromOrder(node.fullOrder)!.score !=
                  current.calification.getFromOrder(node.fullOrder)!.score,
              builder: (context, state) {
                final nnnode = state.calification.getFromOrder(node.fullOrder)!;

                return AppTextField(
                  initialValue: node.score.value,
                  readOnly: node.isLeaf,
                  onChanged: (value) => context.read<ApplyReviewBloc>().add(
                        ApplyReviewScoreChanged(
                          order: node.fullOrder,
                          score: value,
                        ),
                      ),
                );
              },
            ),
          ],
        ),
        // ignore: prefer_const_constructors
        Visibility(
          child: BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
            buildWhen: (previous, current) =>
                previous.calification.getFromOrder(node.fullOrder)!.comment !=
                current.calification.getFromOrder(node.fullOrder)!.comment,
            builder: (context, state) {
              final nnode = state.calification.getFromOrder(node.fullOrder)!;
              final comment = nnode.comment!;

              return AppTextField(
                initialValue: node.comment!.value,
                errorText: comment.error?.message,
                onChanged: (value) => context.read<ApplyReviewBloc>().add(
                      ApplyReviewUpdateCalification(
                        order: node.fullOrder,
                        comment: value,
                      ),
                    ),
              );
            },
          ),
        ),
        if (!node.isLeaf)
          for (final node in node.childrens!) CriteriumTile(node: node),
      ],
    );
  }
}
