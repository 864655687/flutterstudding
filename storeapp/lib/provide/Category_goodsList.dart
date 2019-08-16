import 'package:flutter/widgets.dart';
import 'package:provide/provide.dart';
import '../models/categoryGoodsList.dart';

class CateGorygoodsListProvide with ChangeNotifier{

  List<CategrolistData> goodslist = [];

  //点击大类时更换商品列表
  getGoodslist(List<CategrolistData> list){

    goodslist = list;
    notifyListeners();
  }


}