import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../providers/HeaderProvider.dart';

class Header extends StatelessWidget {
  final int numberOfTasks, numberOfCompletedTasks;

  const Header({
    super.key,
    required this.numberOfTasks,
    required this.numberOfCompletedTasks,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ValueListenableBuilder(
        valueListenable: HeaderProvider(),
        builder: (context, value, child) {
          return Container(
            color: kBackgroundLightColor,
            height: value.height,
            child: Align(
              alignment: Alignment.center,
              child: UnconstrainedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      HeaderProvider().hasAlmostCollapse() ? '' : 'To Do List',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      HeaderProvider().hasAlmostCollapse()
                          ? ''
                          : '$numberOfTasks tasks, $numberOfCompletedTasks completed',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
