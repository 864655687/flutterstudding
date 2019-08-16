import 'package:storeapp/models/category.dart';
import 'package:flutter/foundation.dart';

class ChildCtegory with ChangeNotifier {
  List<BxMallSubDto> childCategorylist = [];
  getChildCategory(List<BxMallSubDto> list) {
     BxMallSubDto all =BxMallSubDto();
    all
    ..mallSubId="00"
    ..mallCategoryId="00"
    ..mallSubName="全部"
    ..comments="null";
    childCategorylist = [all];

    childCategorylist.addAll(list);
    notifyListeners();
  }
}
