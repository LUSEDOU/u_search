import 'package:flutter/material.dart';
import 'package:u_search_api/client.dart';

typedef CalificationNode = ({Criterium criteria, Calification calification});

class CriteriumTile extends StatelessWidget {
  const CriteriumTile({
    required this.criteria,
    required this.calification,
    required this.nodes,
    super.key,
  });

  final Criterium criteria;
  final Calification calification;
  final List<int> nodes;

  @override
  Widget build(BuildContext context) {
    final calificationNodes = <CalificationNode>[];

    bool Function(Calification) matchOrder(Criterium criteria) =>
        (Calification calification) {
          return calification.order == criteria.order;
        };

    for (final criteria in criteria.subCriterias ?? <Criterium>[]) {
      calificationNodes.add(
        (
          criteria: criteria,
          calification:
              calification.subCalifications!.firstWhere(matchOrder(criteria))
        ),
      );
    }
    return Column(
      children: [
        Row(
          children: [
            Text(criteria.name),
            Text(calification.score.toString()),
          ],
        ),
        for (final node in calificationNodes)
          CriteriumTile(
            criteria: node.criteria,
            calification: node.calification,
            nodes: [...nodes, node.calification.order],
          ),
      ],
    );
  }
}

