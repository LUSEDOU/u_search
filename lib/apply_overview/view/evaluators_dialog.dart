import 'package:application_repository/application_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/client.dart';

class EvaluatorsCubit extends Cubit<List<User>> {
  EvaluatorsCubit({
    required ApplicationRepository repository,
  })  : _repository = repository,
        super(const []);

  final ApplicationRepository _repository;

  Future<void> loadEvaluators() async {
    try {
      emit(await _repository.fetchReviewers());
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }
}

class EvaluatorsDialog extends StatelessWidget {
  const EvaluatorsDialog({super.key});

  static Future<User?> show(BuildContext context) {
    return showDialog<User>(
      context: context,
      builder: (_) => const EvaluatorsDialog(),
      routeSettings: const RouteSettings(name: name),
    );
  }

  static const name = '/evaluatorsDialog';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = context.read<ApplicationRepository>();
        return EvaluatorsCubit(repository: repository)..loadEvaluators();
      },
      child: const Dialog(
        child: EvaluatorsView(),
      ),
    );
  }
}

class EvaluatorsView extends StatelessWidget {
  const EvaluatorsView({super.key});

  @override
  Widget build(BuildContext context) {
    final evaluators = context.select((EvaluatorsCubit cubit) => cubit.state);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (evaluators.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: constraints.maxHeight * 0.8,
            maxWidth: constraints.maxWidth * 0.25,
          ),
          child: ListView.builder(
            itemCount: evaluators.length,
            itemBuilder: (context, index) {
              final evaluator = evaluators[index];
              return ListTile(
                trailing: const Icon(Icons.arrow_forward),
                title: Text(evaluator.name),
                subtitle: Text(evaluator.email),
                onTap: () => context.pop(evaluator),
              );
            },
          ),
        );
      },
    );
  }
}
