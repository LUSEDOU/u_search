import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

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
    return Column(
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
                onSubmitted: (value) => context.read<ApplyReviewBloc>().add(
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
    );
  }
}

class ScoreField extends StatefulWidget {
  const ScoreField({
    required this.isEditable,
    required this.maxScore,
    required this.fullOrder,
    this.initialScore,
    super.key,
  });

  final bool isEditable;
  final double maxScore;
  final List<int> fullOrder;
  final String? initialScore;

  @override
  State<ScoreField> createState() => _ScoreFieldState();
}

class _ScoreFieldState extends State<ScoreField> {
  late final TextEditingController _controller;
  late final String _value;

  @override
  void initState() {
    super.initState();
    _value =
        widget.initialScore?.isEmpty ?? true ? '0.0' : widget.initialScore!;
    _controller = TextEditingController(
      text: _value,
    )..addListener(_onChanged);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  void _onChanged() {
    if (widget.isEditable || _value != _controller.text) {
      context.read<ApplyReviewBloc>().add(
            ApplyReviewScoreChanged(
              order: widget.fullOrder,
              score: _controller.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplyReviewBloc, ApplyReviewState>(
      listenWhen: (previous, current) =>
          previous.calification.getFromOrder(widget.fullOrder)?.score !=
          current.calification.getFromOrder(widget.fullOrder)?.score,
      listener: (context, state) {
        LoggerManager().i('ScoreField listener');
        if (!widget.isEditable) {
          _controller.text =
              state.calification.getFromOrder(widget.fullOrder)?.score.value ??
                  '0.0';
        }
      },
      builder: (context, state) {
        final score = state.calification.getFromOrder(widget.fullOrder)?.score;
        return AppTextField(
          readOnly: !widget.isEditable,
          controller: _controller,
          suffix: Text('/ ${widget.maxScore}'),
          errorText: score?.error?.message,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          hintText: '${widget.maxScore}',
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
        );
      },
    );
  }
}

class PercentField extends StatelessWidget {
  const PercentField({required this.percent, super.key});

  final double percent;

  @override
  Widget build(BuildContext context) {
    var percentString = (percent * 100).toStringAsFixed(2);
    if (percentString.endsWith('00')) {
      percentString = percentString.substring(0, percentString.length - 3);
    } else if (percentString.endsWith('0')) {
      percentString = percentString.substring(0, percentString.length - 1);
    }

    return Container(
      width: 70,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppSpacing.lg),
      ),
      alignment: Alignment.center,
      child: Text(
        '$percentString%',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
