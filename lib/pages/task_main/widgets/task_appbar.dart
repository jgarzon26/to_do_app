import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../providers/HeaderProvider.dart';
import '../overlays/task_input.dart';

class TaskAppBar extends StatelessWidget {
  const TaskAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppBar(
        leading: const Icon(
          Icons.menu,
          size: defaultIconSize,
        ),
        title: ValueListenableBuilder(
            valueListenable: HeaderProvider(),
            builder: (context, value, child) {
              return Text(
                HeaderProvider().hasAlmostCollapse() ? 'To Do List' : "",
              );
            }),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(TaskInput());
            },
            icon: const Icon(
              Icons.add,
              size: defaultIconSize,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: defaultIconSize,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: defaultIconSize,
            ),
          ),
        ],
      ),
    );
  }
}
