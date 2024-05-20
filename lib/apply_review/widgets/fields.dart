import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

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
        widget.initialScore?.isEmpty ?? true ? '' : widget.initialScore!;
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
                  '';
        }
      },
      buildWhen: (previous, current) =>
          previous.calification.getFromOrder(widget.fullOrder)?.score !=
          current.calification.getFromOrder(widget.fullOrder)?.score,
      builder: (context, state) {
        final score = state.calification.getFromOrder(widget.fullOrder)?.score;
        LoggerManager().i('ScoreField builder ${widget.fullOrder} with $score');
        return AppTextField(
          readOnly: !widget.isEditable,
          controller: _controller,
          suffix: Center(child: Text('/ ${widget.maxScore}')),
          errorText: score?.displayError?.message,
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
