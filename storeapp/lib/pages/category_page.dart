import 'package:flutter/material.dart';
import '../models/category.dart';
import '../service/service_,method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/catagorychild.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  _CategoryPage createState() => _CategoryPage();
}

class _CategoryPage extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Row(
        children: <Widget>[
          LeftCatgoryNavState(),
          Column(
            children: <Widget>[_RightContentItem()],
          )
        ],
      ),
    );
  }
}

//左侧大类导航

class LeftCatgoryNavState extends StatefulWidget {
  LeftCatgoryNavState({Key key}) : super(key: key);

  _LeftCatgoryNavStateState createState() => _LeftCatgoryNavStateState();
}

class _LeftCatgoryNavStateState extends State<LeftCatgoryNavState> {
  List list = [];
  int listindex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _getCategory();
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 0.5, color: Colors.grey))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftItem(index??0);
        },
      ),
    );
  }

  Widget _leftItem(int index) {
    bool isclick = false;
    isclick=index==listindex?true:false;
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
            color:isclick?Colors.black26:Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(30)),
        ),
      ),
      onTap: () {
        setState(() {
         listindex = index; 
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCtegory>(context).getChildCategory(childList);
      },
    );
  }

  void _getCategory() async {
    try {
      await getCategorydatas().then((val) {
        CategoryModel category = CategoryModel.fromJson(val);
        setState(() {
          list = category.data;
        });
        Provide.value<ChildCtegory>(context).getChildCategory(list[0].bxMallSubDto);
      });
    } catch (e) {
      return print("有错误=======>" + e);
    }
  }
}

class _RightContentItem extends StatefulWidget {
  List list = ['美食', '饮料', '蛋糕', '饮料', '蛋糕', '饮料', '蛋糕', '饮料', '蛋糕'];
  _RightContentItem({Key key}) : super(key: key);

  __RightContentItemState createState() => __RightContentItemState();
}

class __RightContentItemState extends State<_RightContentItem> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCtegory>(
      builder: (context, child, childCtegory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.limeAccent,
              border: Border(
                  bottom:
                      BorderSide(color: Colors.lightGreenAccent, width: 1.0))),
          alignment: Alignment.topLeft,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCtegory.childCategorylist.length,
            itemBuilder: (context, index) {
              return _rightInkewell( childCtegory.childCategorylist[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkewell(BxMallSubDto item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}
