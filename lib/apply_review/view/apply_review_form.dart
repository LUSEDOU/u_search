import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/apply_review/widgets/criterium_tile.dart';

class ApplyReviewForm extends StatelessWidget {
  const ApplyReviewForm({
    required this.node,
    required this.isEditable,
    required this.formKey,
    super.key,
  });

  final CalificationNode node;
  final bool isEditable;
  final Key formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxxlg),
      child: BlocListener<ApplyReviewBloc, ApplyReviewState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            current.status == ApplyReviewStatus.validating,
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Validating review')),
            );
        },
        child: Form(
          key: formKey,
          child: CupertinoScrollbar(
            child: ListView.builder(
              primary: true,
              itemCount: node.children?.length ?? 0,
              itemBuilder: (context, index) {
                final child = node.children![index];
                return CriteriumTile(
                  node: child,
                  isEditable: isEditable,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
