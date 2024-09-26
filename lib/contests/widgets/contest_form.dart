import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:u_search_api/api.dart';

class CriteriumForm extends StatefulWidget {
  const CriteriumForm({
    required this.pointsLeft,
    required this.order,
    super.key,
    this.contest,
  });

  final Criterium? contest;
  final double pointsLeft;
  final int order;

  static Future<Criterium?> show(
    BuildContext context, {
    required double pointsLeft,
    required int order,
    Criterium? contest,
  }) async {
    return showDialog<Criterium>(
      context: context,
      builder: Dialog(
        child: CriteriumForm(
          pointsLeft: pointsLeft,
          order: order,
          contest: contest,
        ),
      ).build,
    );
  }

  @override
  State<CriteriumForm> createState() => _CriteriumFormState();
}

class _CriteriumFormState extends State<CriteriumForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _scoreController;
  late final TextEditingController _minscoreController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController(text: widget.contest?.name);
    _descriptionController =
        TextEditingController(text: widget.contest?.description);
    _scoreController =
        TextEditingController(text: widget.contest?.maxScore.toString());
    _minscoreController =
        TextEditingController(text: widget.contest?.minScore.toString());
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.darkAqua,
              borderRadius: BorderRadius.circular(AppSpacing.lg),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Text(
                    widget.contest == null
                        ? 'Nuevo criterio'
                        : 'Editar criterio',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.lg),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppTextField(
                          label: 'Título',
                          isRequired: true,
                          controller: _titleController,
                          hintText: 'Creatividad',
                        ),
                        AppTextField(
                          label: 'Descripción',
                          isRequired: true,
                          controller: _descriptionController,
                          hintText: 'Creatividad en la presentación',
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: AppTextField(
                                label: 'Puntaje',
                                controller: _scoreController,
                                hintText: '10',
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                validator: (value) {
                                  final score = double.tryParse(value!);
                                  if (score == null) return 'Número inválido';
                                  if (score > widget.pointsLeft) {
                                    return 'Menor a'
                                        ' ${widget.pointsLeft}';
                                  }
                                  return null;
                                },
                                isRequired: true,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: AppTextField(
                                label: 'Min. Puntaje *',
                                controller: _minscoreController,
                                hintText: '3',
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d+\.?\d{0,2}'),
                                  ),
                                ],
                                validator: (value) {
                                  if (value?.isEmpty ?? true) return null;
                                  final score =
                                      double.tryParse(_scoreController.text);

                                  if (score == null) return null;

                                  final minScore = double.tryParse(value ?? '');
                                  if (minScore == null) return null;

                                  if (minScore > score) {
                                    return 'Menor a $score';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxlg),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: AppButton.outlinedWhite(
                                onPressed: context.pop,
                                child: const Text('Cancelar'),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: AppButton.darkAqua(
                                onPressed: () {
                                  if (!(_formKey.currentState?.validate() ??
                                      true)) return;

                                  _formKey.currentState?.save();
                                  Criterium(
                                    order: widget.order,
                                    name: _titleController.text,
                                    description: _descriptionController.text,
                                    maxScore:
                                        double.parse(_scoreController.text),
                                    minScore: double.tryParse(
                                      _minscoreController.text
                                    ),
                                  );
                                  // Navigator.of(context).pop(
                                  //   Criterium(
                                  //     name: _titleController.text,
                                  //     description: _descriptionController.text,
                                  //     maxScore: _score!,
                                  //     minScore: double.tryParse(
                                  //         _minscoreController.text),
                                  //   ),
                                  // );
                                },
                                child: const Text('Guardar'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
