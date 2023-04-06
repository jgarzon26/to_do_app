import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/constants.dart';
import 'package:uuid/uuid.dart';

class TaskTile extends StatelessWidget {
  final _checkBox = {
    'isCheck': false,
  };

  final String title, description;

  TaskTile({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Slidable(
        groupTag: const Uuid().v4(),
        startActionPane: ActionPane(
          dismissible: const ActionPaneOnDismiss(
            backgroundColor: kCheckColor,
            icon: Icons.edit,
          ),
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              onPressed: (context) {},
              backgroundColor: kCheckColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        endActionPane: ActionPane(
          dismissible: const ActionPaneOnDismiss(
            backgroundColor: kDeleteColor,
            icon: Icons.delete,
          ),
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              onPressed: (context) {},
              backgroundColor: kDeleteColor,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StatefulBuilder(builder: (context, setState) {
                return Checkbox(
                  value: _checkBox['isCheck'],
                  onChanged: (value) {
                    setState(() {
                      _checkBox['isCheck'] = value!;
                    });
                  },
                );
              }),
            ],
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}

class ActionPaneOnDismiss extends StatelessWidget {
  const ActionPaneOnDismiss({
    super.key,
    required this.backgroundColor,
    required this.icon,
  });

  final Color backgroundColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Icon(
        icon,
        size: 50,
        color: Colors.white,
      ),
    );
  }
}
