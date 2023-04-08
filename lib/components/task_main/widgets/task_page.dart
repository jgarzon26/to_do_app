import 'package:flutter/material.dart';

import '../../../pages/completed_list.dart';
import '../../../pages/to_do_list.dart';
import '../../../providers/HeaderProvider.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({
    super.key,
    required ScrollController secondScrollController,
    required int pageIndex,
  })  : _secondScrollController = secondScrollController,
        _pageIndex = pageIndex;

  final ScrollController _secondScrollController;
  final int _pageIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        controller: _secondScrollController,
        physics: HeaderProvider().hasCollapsed
            ? const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
                decelerationRate: ScrollDecelerationRate.fast,
              )
            : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverToBoxAdapter(
            child: IndexedStack(
              index: _pageIndex,
              children: const [
                ToDoList(),
                CompletedList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
