import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

class ApplyReviewForm extends StatelessWidget {
  const ApplyReviewForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final apply = context.select(
      (ApplyReviewBloc bloc) => bloc.state.apply,
    );

    return CupertinoScrollbar(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        primary: true,
        child: Column(
          children: [
            for (final criteria in apply.contest.criterias)
              Column(
                children: [
                  CriteriaTile(criteria: criteria),
                  const Divider(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
