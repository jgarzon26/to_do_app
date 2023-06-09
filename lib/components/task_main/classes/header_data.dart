import 'package:uuid/uuid.dart';

class HeaderDetail {
  final String id = const Uuid().v4();
  double height;
  String title;
  bool hasCollapsed = false;

  static const double minHeight = 50;
  static const double maxHeight = 300;

  HeaderDetail({
    required this.height,
    required this.title,
  });
}
