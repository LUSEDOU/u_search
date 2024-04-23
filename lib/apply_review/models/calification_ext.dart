import 'package:form_inputs/form_inputs.dart';
import 'package:u_search_api/client.dart';

class CalificationNode extends Criterium {
  const CalificationNode({
    required super.order,
    required super.name,
    required super.description,
    required this.fullOrder,
    required this.score,
    super.percent,
    super.maxScore,
    super.subCriterias,
    super.minScore,
    this.childrens,
    this.comment,
  });

  factory CalificationNode.fromReview(Review review) {
    final calification = review.calification;

    final childrens = <CalificationNode>[];
    for (final criterium in review.criterias) {
      final subCalification = calification.isCreated
          ? calification.subCalifications!
              .firstWhere((cal) => cal.order == criterium.order)
          : null;

      final node = criterium.toNode(subCalification);

      childrens.add(node);
    }

    return CalificationNode(
      order: 0,
      name: '',
      description: '',
      fullOrder: const [],
      score: Score.pure(score: calification.score.toString()),
    );
  }

  // factory CalificationNode.from({
  //   required Criterium criterium,
  //   required Calification calification,
  //   List<int> fullOrder = const [],
  // }) {
  //   final order = [...fullOrder, criterium.order];
  //   final childrens = criterium.subCriterias?.map(
  //     (subCriteria) {
  //       return CalificationNode.from(
  //         criterium: subCriteria,
  //         fullOrder: order,
  //         calification: calification.subCalifications!
  //             .firstWhere((cal) => cal.order == subCriteria.order),
  //       );
  //     },
  //   ).toList();
  //
  //   return CalificationNode(
  //     order: criterium.order,
  //     name: criterium.name,
  //     description: criterium.description,
  //     childrens: childrens,
  //     fullOrder: fullOrder,
  //     score: Score.pure(
  //       score: calification.score.toString(),
  //       maxScore: criterium.maxScore,
  //     ),
  //     comment: childrens?.isEmpty ?? true
  //         ? null
  //         : Comment.pure(
  //             value: calification.comment ?? '',
  //           ),
  //   );
  // }
  //
  final Score score;
  final Comment? comment;
  final List<int> fullOrder;

  final List<CalificationNode>? childrens;

  @override
  List<Criterium>? get subCriterias => childrens;

  bool get isLeaf => subCriterias?.isEmpty ?? true;

  bool validate() {
    if (isLeaf) {
      return score.isValid && (comment?.isValid ?? true);
    }

    return childrens?.every((child) => child.validate()) ?? true;
  }

  CalificationNode copyWith({
    Score? score,
    Comment? comment,
    List<CalificationNode>? childrens,
  }) {
    return CalificationNode(
      order: order,
      name: name,
      fullOrder: fullOrder,
      description: description,
      score: score ?? this.score,
      comment: comment ?? this.comment,
      childrens: childrens ?? this.childrens,
    );
  }

  CalificationNode? getFromOrder(List<int> order) {
    if (order.isEmpty) {
      return null;
    }

    if (order.first == this.order) {
      return this;
    }

    final node = childrens?.firstWhere(
      (child) => child.order == order.first,
    );

    return node?.getFromOrder(order.sublist(1));
  }

  CalificationNode updateComment({
    required String comment,
    required List<int> order,
  }) {
    if (order.isEmpty) {
      return copyWith(
        comment: Comment.dirty(value: comment),
      );
    }

    final index = childrens?.indexWhere(
      (child) => child.order == order.first,
    );

    if (index case null || -1) {
      throw Exception('Invalid order');
    }
    final node = childrens![index];

    final upNode = node.updateComment(
      comment: comment,
      order: order.sublist(1),
    );

    final upChildrens = [...childrens!];
    upChildrens[index] = upNode;

    return copyWith(
      childrens: upChildrens,
    );
  }

  (CalificationNode, double) updateScore({
    required double score,
    required List<int> order,
  }) {
    if (order.isEmpty) {
      throw Exception('Invalid order');
    }

    if (order.first == this.order) {
      final oldScore = double.tryParse(this.score.value) ?? 0;
      return (
        copyWith(
          score: Score.dirty(value: '$score', maxScore: maxScore),
        ),
        (score - oldScore) * percent,
      );
    }

    final index = childrens?.indexWhere(
      (child) => child.order == order.first,
    );

    if (index case null || -1) {
      throw Exception('Invalid order');
    }
    final node = childrens![index];

    final (upNode, diff) = node.updateScore(
      score: score,
      order: order.sublist(1),
    );

    final upChildrens = [...childrens!];
    upChildrens[index] = upNode;

    final upScore = double.tryParse(this.score.value) ?? 0;
    final newScore = upScore + diff;

    return (
      copyWith(
        score: Score.pure(score: '$newScore', maxScore: maxScore),
        childrens: upChildrens,
      ),
      diff * percent,
    );
  }

  Calification toModels() {
    if (isLeaf) {
      return Calification(
        order: order,
        score: score.numericValue!,
        comment: comment?.value,
      );
    }

    final subCalifications = childrens!.map(
      (child) => child.toModels(),
    );

    return Calification(
      order: order,
      score: score.numericValue!,
      subCalifications: subCalifications.toList(),
    );
  }
}

extension CriteriumExt on Criterium {
  CalificationNode toNode(
    Calification? calification, {
    List<int> parentOrder = const [],
  }) {
    final fullOrder = [...parentOrder, order];
    return CalificationNode(
      order: order,
      name: name,
      description: description,
      fullOrder: fullOrder,
      maxScore: maxScore,
      minScore: minScore,
      percent: percent,
      score: Score.pure(
        score: calification?.score.toString() ?? '',
        maxScore: maxScore,
      ),
      childrens: subCriterias?.map(
        (subCriteria) {
          final cal = calification?.subCalifications?.firstWhere(
            (cal) => cal.order == subCriteria.order,
          );
          return subCriteria.toNode(cal, parentOrder: fullOrder);
        },
      ).toList(),
      comment: subCriterias?.isEmpty ?? true
          ? Comment.pure(value: calification?.comment ?? '')
          : null,
    );
  }
}
