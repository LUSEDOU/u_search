import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart' as og;
import 'package:u_search_api/client.dart';
import 'package:u_search_flutter/utils/logger_manager.dart';

class CalificationNode extends Criterium with EquatableMixin {
  const CalificationNode({
    required super.order,
    required super.name,
    required super.description,
    required this.fullOrder,
    required this.score,
    super.percent,
    super.maxScore,
    super.minScore,
    this.children,
    this.comment,
  });

  factory CalificationNode.fromReview(Review review) {
    final calification = review.calification;
    final children = <CalificationNode>[];
    for (final criterium in review.criterias) {
      final subCalification = calification.isCreated
          ? calification.subCalifications!
              .firstWhere((cal) => cal.order == criterium.order)
          : null;

      final node = criterium.toNode(subCalification);

      children.add(node);
    }

    return CalificationNode(
      order: 0,
      name: '',
      description: '',
      fullOrder: const [],
      children: children,
      maxScore: 100,
      score: Score.pure(
        score: calification.isCreated ? calification.score.toString() : '0.0',
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({bool showChildren = true}) {
    final scoreValue = double.tryParse(score.value);
    return {
      'order': order,
      'name': name,
      'description': description,
      'score': '${score.isValid ? '' : 'INVALID'} '
          '${scoreValue ?? ''} / $maxScore',
      'percent': percent,
      if (isLeaf) 'comment': comment?.value ?? '',
      if (!isLeaf && showChildren)
        'children': children
            ?.map((child) => child.toJson(showChildren: false))
            .toList(),
    };
  }

  final Score score;
  final Comment? comment;
  final List<int> fullOrder;

  final List<CalificationNode>? children;

  @override
  List<Criterium>? get subCriterias => children;

  bool get isLeaf => subCriterias?.isEmpty ?? true;
  bool get isValid => score.isValid && (comment?.isValid ?? true);

  bool validate() {
    if (isLeaf) {
      return score.isValid && (comment?.isValid ?? true);
    }

    return children?.every((child) => child.validate()) ?? true;
  }

  CalificationNode copyWith({
    Score? score,
    Comment? comment,
    List<CalificationNode>? children,
  }) {
    return CalificationNode(
      order: order,
      name: name,
      fullOrder: fullOrder,
      description: description,
      score: score ?? this.score,
      comment: comment ?? this.comment,
      children: children ?? this.children,
      percent: percent,
      maxScore: maxScore,
      minScore: minScore,
    );
  }

  CalificationNode? getFromOrder(List<int> order) {
    if (order.isEmpty) return this;

    final node = children?.firstWhere(
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

    final index = children?.indexWhere(
      (child) => child.order == order.first,
    );

    if (index case null || -1) {
      throw Exception('Invalid order');
    }
    final node = children![index];

    final upNode = node.updateComment(
      comment: comment,
      order: order.sublist(1),
    );

    final upChildrens = [...children!];
    upChildrens[index] = upNode;

    return copyWith(
      children: upChildrens,
    );
  }

  (CalificationNode, double) updateScore({
    required double? score,
    required List<int> order,
  }) {
    if (order.isEmpty) {
      final oldScore = this.score.isValid ? this.score.numericValue! : 0;
      final newScore = Score.dirty(value: '$score', maxScore: maxScore);
      final scoreValue = newScore.isValid ? newScore.numericValue! : 0;
      return (
        copyWith(score: newScore),
        (scoreValue - oldScore) * percent,
      );
    }

    final index = children?.indexWhere(
      (child) => child.order == order.first,
    );
    if (index case null || -1) throw Exception('Invalid order');

    final child = children![index];

    final (updated, diff) =
        child.updateScore(score: score, order: order.sublist(1));

    final childrens = [...children!];
    childrens[index] = updated;

    final uDiff = diff * percent;
    final oldScore = double.tryParse(this.score.value) ?? 0;
    final newScore = oldScore + diff;

    return (
      copyWith(
        children: childrens,
        score: Score.pure(score: '$newScore', maxScore: maxScore),
      ),
      uDiff,
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

    final subCalifications = children?.map(
      (child) => child.toModels(),
    );

    return Calification(
      order: order,
      score: score.numericValue!,
      subCalifications: subCalifications?.toList(),
    );
  }

  @override
  List<Object?> get props => [score, comment, children];
}

extension CriteriumExt on Criterium {
  CalificationNode toNode(
    Calification? calification, {
    List<int> parentOrder = const [],
  }) {
    final fullOrder = [...parentOrder, order];
    final scoreValue = calification?.score ?? .0;
    return CalificationNode(
      order: order,
      name: name,
      description: description,
      fullOrder: fullOrder,
      maxScore: maxScore,
      minScore: minScore,
      percent: percent,
      score: Score.pure(score: '$scoreValue', maxScore: maxScore),
      children: subCriterias?.map(
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

class Comment extends og.Comment with EquatableMixin {
  const Comment.pure({String? value}) : super.pure(value: value ?? '');

  const Comment.dirty({super.value}) : super.dirty();

  @override
  List<Object?> get props => [value, isPure, error];
}

class Score extends og.Score with EquatableMixin {
  const Score.pure({String? score, super.maxScore})
      : super.pure(score: score ?? '');

  /// {@macro score}
  const Score.dirty({super.value, super.maxScore}) : super.dirty();

  @override
  List<Object?> get props => [value, isPure, error];
}
