import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

class CriteriumTile extends StatelessWidget {
  const CriteriumTile({
    required this.node,
    required this.isEditable,
    this.subNode = false,
    super.key,
  });

  final CalificationNode node;
  final bool isEditable;
  final bool subNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      node.name,
                      style: subNode
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      node.description,
                      style: subNode
                          ? Theme.of(context).textTheme.bodyMedium
                          : Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xlg),
                      child: PercentField(
                        percent: node.percent,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: ScoreField(
                      isEditable: isEditable && node.isLeaf,
                      maxScore: node.maxScore,
                      fullOrder: node.fullOrder,
                      initialScore: node.score.value,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // ignore: prefer_const_constructors
          BlocBuilder<ApplyReviewBloc, ApplyReviewState>(
            buildWhen: (previous, current) =>
                previous.calification.getFromOrder(node.fullOrder)?.comment !=
                current.calification.getFromOrder(node.fullOrder)?.comment,
            builder: (context, state) {
              final nnode = state.calification.getFromOrder(node.fullOrder);
              final comment = nnode?.comment;

              return Visibility(
                visible: node.isLeaf,
                child: AppTextField(
                  initialValue: node.comment?.value,
                  errorText: comment?.displayError?.message,
                  readOnly: !isEditable,
                  maxLines: 3,
                  onChanged: (value) => context.read<ApplyReviewBloc>().add(
                        ApplyReviewCommentChanged(
                          order: node.fullOrder,
                          comment: value,
                        ),
                      ),
                ),
              );
            },
          ),
          if (!node.isLeaf)
            Padding(
              padding: const EdgeInsets.only(left: AppSpacing.xlg),
              child: Column(
                children: [
                  for (final node in node.children ?? <CalificationNode>[])
                    CriteriumTile(
                      node: node,
                      isEditable: isEditable,
                      subNode: true,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
