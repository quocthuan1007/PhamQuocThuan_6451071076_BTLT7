import 'package:flutter/material.dart';
import '../models/task.dart';
import '../controller/task_controller.dart';
import '../widget/task_item.dart';

class TaskListView extends StatefulWidget {
  const TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final TaskController _controller = TaskController();
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    try {
      final tasks = await _controller.getTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _deleteTask(int index) async {
    final task = _tasks[index];
    try {
      bool success = await _controller.deleteTask(task.id);
      if (success && mounted) {
        setState(() {
          _tasks.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete task')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task List (Delete API)')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return TaskItem(
                  task: task,
                  onDelete: () => _deleteTask(index),
                );
              },
            ),
    );
  }
}
