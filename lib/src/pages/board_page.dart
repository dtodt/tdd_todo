import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/cubits/board_cubit.dart';
import 'package:todo/src/models/task.dart';
import 'package:todo/src/states/board_state.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  late BoardCubit cubit;

  @override
  Widget build(BuildContext context) {
    cubit = context.watch<BoardCubit>();
    final state = cubit.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: switch (state) {
        EmptyBoardState _ => _emptyState(),
        FailureBoardState failure => _failureState(failure.message),
        LoadedBoardState loaded => _loadedState(loaded.tasks),
        (_) => const SizedBox(),
      },
    );
  }

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      cubit.fetchTasks();
    });
  }

  Widget _emptyState() {
    return const Center(
      key: Key('EmptyState'),
      child: Text('Adicione uma nova task'),
    );
  }

  Widget _failureState(String message) {
    return Center(
      key: const Key('FailureState'),
      child: Text(
        'Falha ao listar as tasks\n\n$message',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _loadedState(List<Task> tasks) {
    return ListView.builder(
      key: const Key('LoadedState'),
      itemBuilder: (context, index) {
        final task = tasks.elementAt(index);
        return CheckboxListTile(
          onChanged: (_) => cubit.checkTask(task),
          title: Text(task.description),
          value: task.checked,
        );
      },
      itemCount: tasks.length,
    );
  }
}
