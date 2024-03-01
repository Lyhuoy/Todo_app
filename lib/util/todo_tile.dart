import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? onDeleteTask;

  const ToDoTile({super.key, required this.onChanged, required this.isCompleted, required this.taskName, required this.onDeleteTask});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(15),
            onPressed: onDeleteTask,
            backgroundColor: Colors.red,
            icon: Icons.delete,
            foregroundColor: Colors.white,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.deepPurple[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Checkbox(
              value: isCompleted,
              onChanged: onChanged,
              activeColor: Colors.white,
              checkColor: Colors.deepPurple[400],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                taskName,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
