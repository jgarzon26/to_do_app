import 'package:flutter/material.dart';
import 'package:to_do_app/pages/task_main/classes/header_data.dart';

enum HeaderState { expanded, collapsed }

class HeaderProvider extends ValueNotifier<HeaderDetail> {
  HeaderProvider._instance()
      : super(
          HeaderDetail(height: HeaderDetail.maxHeight),
        );
  static final HeaderProvider _shared = HeaderProvider._instance();
  factory HeaderProvider() => _shared;

  bool get hasCollapsed => value.hasCollapsed;
  set hasCollapsed(bool val) => value.hasCollapsed = val;

  void subtractHeight(double offset) {
    if (value.height - offset <= HeaderDetail.minHeight) {
      resetHeight(false);
      notifyListeners();
      return;
    }
    value.height -= offset;
    notifyListeners();
  }

  void addHeight(double offset) {
    if (value.height + offset >= HeaderDetail.maxHeight) {
      resetHeight(true);
      notifyListeners();
      return;
    }
    value.height += offset;
    notifyListeners();
  }

  void resetHeight(bool toMaxHeight) {
    toMaxHeight
        ? value.height = HeaderDetail.maxHeight
        : value.height = HeaderDetail.minHeight;
    notifyListeners();
  }

  bool hasAlmostCollapse() {
    return value.height <= HeaderDetail.minHeight + 50;
  }
}
