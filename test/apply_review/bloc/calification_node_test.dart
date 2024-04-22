import 'package:flutter_test/flutter_test.dart';
import 'package:u_search_api/client.dart';
import 'package:u_search_flutter/apply_review/apply_review.dart';

void main() {
  group('CalificationNode', () {
    late CalificationNode calificationNode;

    setUp(() {
      Criterium criteriumFactory(int index, double percentage) => Criterium(
            order: index,
            name: index.toString(),
            description: '',
          );
      Calification calificationFactory(int index, double score) => Calification(
            order: index,
            score: score,
          );
      calificationNode = CalificationNode(
        criteria: criteriumFactory(1, 1),
        calification: calificationFactory(1, 4),
        order: [],
        nodes: [
          CalificationNode(
            criteria: criteriumFactory(1, 1 / 3),
            calification: calificationFactory(1, 4),
            order: [],
            nodes: [],
          ),
          CalificationNode(
            criteria: criteriumFactory(2, 1 / 3),
            calification: calificationFactory(1, 2),
            order: [],
            nodes: [
              CalificationNode(
                criteria: criteriumFactory(1, 1),
                calification: calificationFactory(1, 4),
                order: [],
                nodes: [],
              ),
              CalificationNode(
                criteria: criteriumFactory(1, 1),
                calification: calificationFactory(1, 4),
                order: [],
                nodes: [],
              ),
            ],
          ),
          CalificationNode(
            criteria: criteriumFactory(3, 1 / 3),
            calification: calificationFactory(1, 4),
            order: [],
            nodes: [],
          ),
        ],
      );
    });
  });
}
