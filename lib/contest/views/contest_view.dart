import 'package:flutter/material.dart';

class ContestPage extends StatelessWidget {
  const ContestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ContestView();
  }
}

class ContestView extends StatelessWidget {
  const ContestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contest'),
      ),
      body: const ContestPage(),
    );
  }
}
