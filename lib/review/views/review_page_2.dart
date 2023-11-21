import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_search_api/u_search_api.dart';
import 'package:u_search_flutter/review/review.dart';
import 'package:intl/intl.dart';
import 'package:u_search_flutter/review/views/applies_factory.dart';

class ReviewPage2 extends StatelessWidget {
  const ReviewPage2({super.key});

  @override
  Widget build(BuildContext context) {

    final apply = apply2;

    return BlocProvider(
      create: (_) => ReviewBloc(
        apply: apply,
        reviewRepository: const ReviewRepository(),
      ),
      child: const ReviewView2(),
    );
  }
}

class ReviewView2 extends StatefulWidget {
  const ReviewView2({super.key});

  @override
  State<ReviewView2> createState() => _ReviewView2State();
}

class _ReviewView2State extends State<ReviewView2> {
  @override
  Widget build(BuildContext context) {
    final criterias = context.select(
      (ReviewBloc bloc) => bloc.state.criterias,
    );
    final isNew = context.select(
      (ReviewBloc bloc) => bloc.state.isNew,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isNew ? 'New Review' : 'Review',
        ),
      ),
      body: CupertinoScrollbar(
        child: ListView(
          primary: true,
          padding: const EdgeInsets.all(16),
          children: [
            for (final criteria in criterias)
              Column(
                children: [
                  CriteriaListTile(criteria: criteria),
                  const Divider(),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}


class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total'),
          Text(
            '${context.select((ReviewBloc bloc) => bloc.state.totalScore)}',
          ),
        ],
      ),
    );
  }
}


class PercentBullet extends StatelessWidget {
  const PercentBullet(
    this.percent, {
    super.key,
  });

  final double percent;

  @override
  Widget build(BuildContext context) {
    // Add a percent sign and make it with 0 decimals
    final perCent = '${(percent * 100).toStringAsFixed(0)}%';
    final theme = Theme.of(context);

    return Container(
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: theme.colorScheme.primary.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        child: Text(
          perCent,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class ToolTip extends StatelessWidget {
  const ToolTip(
    this.description, {
    super.key,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showDialog(
        context: context,
        builder: _buildDialog,
      ),
      icon: const Icon(Icons.info),
    );
  }

  Dialog _buildDialog(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(description),
      ),
    );
  }
}
