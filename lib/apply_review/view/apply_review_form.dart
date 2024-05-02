import 'package:app_ui/app_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';
import 'package:u_search_flutter/apply_review/widgets/criterium_tile.dart';

class ApplyReviewForm extends StatelessWidget {
  const ApplyReviewForm({
    required this.node,
    required this.isEditable,
    super.key,
  });

  final CalificationNode node;
  final bool isEditable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxxlg),
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
    );
  }
}
