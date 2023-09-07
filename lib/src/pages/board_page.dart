import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/cubits/board_cubit.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<BoardCubit>();
    final state = cubit.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      context.read<BoardCubit>().fetchTasks();
    });
  }
}
