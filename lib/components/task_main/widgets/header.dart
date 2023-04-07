import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/providers/HeaderProvider.dart';
import 'package:to_do_app/providers/OverallTaskProvider.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<OverallTaskProvider>();
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
                      HeaderProvider().hasAlmostCollapse() ? '' : value.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      HeaderProvider().hasAlmostCollapse()
                          ? ''
                          : '${taskProvider.taskCount} tasks, ${taskProvider.completedTaskCount} completed',
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
