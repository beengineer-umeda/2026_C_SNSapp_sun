import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 1,
      tooltip: '投稿する',
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: const CircleBorder(),
      child: Icon(Icons.add, color: Theme.of(context).colorScheme.onPrimary),
      onPressed: () {},
    );
  }
}
