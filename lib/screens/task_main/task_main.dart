import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/components/task_tile.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/providers/HeaderProvider.dart';
import 'package:to_do_app/providers/OverallTaskProvider.dart';
import 'package:to_do_app/screens/task_main/widgets/header.dart';

class TaskMain extends StatefulWidget {
  const TaskMain({Key? key}) : super(key: key);

  @override
  State<TaskMain> createState() => _TaskMainState();
}

class _TaskMainState extends State<TaskMain> {
  final ScrollController _mainScrollController = ScrollController();
  final _maxScrollExtent = 30.0;

  @override
  void initState() {
    _mainScrollController.addListener(() {
      if (_mainScrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          HeaderProvider().subtractHeight(_mainScrollController.offset);
        });
      } else {
        setState(() {
          HeaderProvider().addHeight(_mainScrollController.offset);
          HeaderProvider().hasCollapsed = false;
        });
      }

      if (_mainScrollController.position.pixels >= _maxScrollExtent) {
        setState(() {
          _mainScrollController.position.setPixels(_maxScrollExtent);
          _mainScrollController.jumpTo(_maxScrollExtent);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _mainScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notify) {
        if (notify is ScrollUpdateNotification) {
          if (notify.metrics.pixels == 0) {
            setState(() {
              HeaderProvider().resetHeight(true);
              HeaderProvider().hasCollapsed = false;
            });
          }
          if (notify.metrics.pixels == _maxScrollExtent) {
            setState(() {
              HeaderProvider().resetHeight(false);
              HeaderProvider().hasCollapsed = true;
            });
          }
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: ChangeNotifierProvider(
            create: (context) => OverallTaskProvider(),
            child: CustomScrollView(
              controller: _mainScrollController,
              slivers: [
                const Header(
                  numberOfTasks: 10,
                  numberOfCompletedTasks: 5,
                ),
                SliverFillRemaining(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: CustomScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      slivers: [
                        SliverToBoxAdapter(
                          child: AppBar(
                            leading: const Icon(
                              Icons.menu,
                              size: defaultIconSize,
                            ),
                            title: Text(
                              HeaderProvider().hasAlmostCollapse()
                                  ? 'To Do List'
                                  : "",
                            ),
                            actions: [
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
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final taskProvider =
                                  context.watch<OverallTaskProvider>();
                              if (index >= OverallTaskProvider().taskCount) {
                                return null;
                              }
                              return TaskTile(
                                title: taskProvider.tasks[index].title,
                                description:
                                    taskProvider.tasks[index].description,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: IconTheme(
          data: const IconThemeData(size: defaultIconSize),
          child: CurvedNavigationBar(
            index: 1,
            items: const [
              Icon(CupertinoIcons.pen),
              Icon(Icons.book),
              Icon(Icons.checklist),
            ],
            onTap: (index) {
              //Handle button tap
            },
            backgroundColor: kBackgroundColor,
            color: kBackgroundLightColor,
          ),
        ),
      ),
    );
  }
}
