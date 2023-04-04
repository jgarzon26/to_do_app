import 'package:flutter/material.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  final int numberOfTasks, numberOfCompletedTasks;

  const Header({
    super.key,
    required this.numberOfTasks,
    required this.numberOfCompletedTasks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundLightColor,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Align(
        alignment: Alignment.center,
        child: UnconstrainedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'To Do List',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '$numberOfTasks tasks, $numberOfCompletedTasks completed',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
