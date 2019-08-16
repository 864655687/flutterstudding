import 'package:storeapp/models/category.dart';
import 'package:flutter/foundation.dart';

class ChildCtegory with ChangeNotifier {
  List<BxMallSubDto> childCategorylist = [];

  int childIndex = 0;//子类高亮索引
  String categpruId = '4';
  getChildCategory(List<BxMallSubDto> list) {
     BxMallSubDto all =BxMallSubDto();
     childIndex = 0;
    all
    ..mallSubId="00"
    ..mallCategoryId="00"
    ..mallSubName="全部"
    ..comments="null";
  
    childCategorylist = [all];

    childCategorylist.addAll(list);
    notifyListeners();
  }

  changeChildIndex(int index){
    childIndex = index;
    notifyListeners();
  }
}
