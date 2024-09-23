import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      home: TaskList(),
    );
  }
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<Task> _tasks = [];

  final TextEditingController _taskController = TextEditingController();

  void _addTask(String taskName) {
    if (taskName.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: taskName));
      });
      _taskController.clear();
    }
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Nova Tarefa',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: _addTask,
              ),
            ),
            ElevatedButton(
              onPressed: () => _addTask(_taskController.text),
              child: Text('Adicionar Tarefa'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TaskCard(
                      task: _tasks[index],
                      onChanged: () => _toggleTaskCompletion(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onChanged;

  const TaskCard({required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          task.name,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value) => onChanged(),
        ),
      ),
    );
  }
}