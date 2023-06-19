import 'package:flutter/foundation.dart';
import 'package:flutter_clock_app/enums.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;
  MenuInfo(
    this.menuType, {
    required this.title,
    required this.imageSource,
  });

  MenuInfo copyWith({
    MenuType? menuType,
    String? title,
    String? imageSource,
  }) {
    return MenuInfo(
      menuType ?? this.menuType,
      title: title ?? this.title,
      imageSource: imageSource ?? this.imageSource,
    );
  }

  @override
  String toString() =>
      'MenuInfo(menuType: $menuType, title: $title, imageSource: $imageSource)';

  updateMenuInfo(MenuInfo menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}
