import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:to_do_app/components//task_main/widgets/header.dart';
import 'package:to_do_app/components/task_main/widgets/task_appbar.dart';
import 'package:to_do_app/components/task_main/widgets/task_page.dart';
import 'package:to_do_app/constants.dart';
import 'package:to_do_app/providers/HeaderProvider.dart';

class TaskMain extends StatefulWidget {
  const TaskMain({Key? key}) : super(key: key);

  @override
  State<TaskMain> createState() => _TaskMainState();
}

class _TaskMainState extends State<TaskMain> {
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _secondScrollController = ScrollController();

  bool _enableMainScroll = true;

  final _maxScrollExtent = 30.0;

  int _pageIndex = 0;

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
    _secondScrollController.addListener(() {
      if (_secondScrollController.position.pixels >
          _secondScrollController.position.minScrollExtent) {
        setState(() {
          _enableMainScroll = false;
        });
      } else {
        setState(() {
          _enableMainScroll = true;
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
          child: CustomScrollView(
            physics: _enableMainScroll
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            controller: _mainScrollController,
            slivers: [
              const Header(),
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
                  child: Column(
                    children: [
                      const TaskAppBar(),
                      TaskPage(
                        secondScrollController: _secondScrollController,
                        pageIndex: _pageIndex,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: IconTheme(
          data: const IconThemeData(size: defaultIconSize),
          child: CurvedNavigationBar(
            animationDuration: const Duration(milliseconds: 300),
            items: const [
              Icon(Icons.book),
              Icon(Icons.checklist),
            ],
            onTap: (index) {
              setState(() {
                _pageIndex = index;
                switch (index) {
                  case 0:
                    HeaderProvider().headerTitle = 'To Do List';
                    break;
                  case 1:
                    HeaderProvider().headerTitle = 'Completed';
                    break;
                }
              });
            },
            backgroundColor: kBackgroundColor,
            color: kBackgroundLightColor,
          ),
        ),
      ),
    );
  }
}
