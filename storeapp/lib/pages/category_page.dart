import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/categoryGoodsList.dart';
import '../service/service_,method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import '../provide/catagorychild.dart';
import '../provide/Category_goodsList.dart';



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
            children: <Widget>[_RightContentItem(), CategoreGoodsList()],
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
    _getCategorylist();
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
          return _leftItem(index ?? 0);
        },
      ),
    );
  }

  Widget _leftItem(int index) {
    bool isclick = false;
    isclick = index == listindex ? true : false;
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
            color: isclick ? Colors.black26 : Colors.white,
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
        _getCategorylist();
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
        Provide.value<ChildCtegory>(context)
            .getChildCategory(category.data[0].bxMallSubDto);
      });
    } catch (e) {
      return print("有错误=======>" + e);
    }
  }

  void _getCategorylist({String categoryId}) async {
    await getCategorylist().then((val) {
      CategoryGoodsListModel goodslist = CategoryGoodsListModel.fromJson(val);
      Provide.value<CateGorygoodsListProvide>(context)
          .getGoodslist(goodslist.data);
    });
  }
}

//右侧顶部导航
class _RightContentItem extends StatefulWidget {
  _RightContentItem({Key key}) : super(key: key);

  __RightContentItemState createState() => __RightContentItemState();
}

ScrollController _scrollcontroller = ScrollController();
class __RightContentItemState extends State<_RightContentItem> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCtegory>(
      builder: (context, child, childCtegory) {
        try{
            _scrollcontroller.jumpTo(0.0);
        }catch(e){

          print("第一次初始化${e}");

        }

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
            controller: _scrollcontroller,
            scrollDirection: Axis.horizontal,
            itemCount: childCtegory.childCategorylist.length,
            itemBuilder: (context, index) {
              return _rightInkewell(index,childCtegory.childCategorylist[index]);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkewell(int index,BxMallSubDto item) {
    bool isCilck = false;
    isCilck = (index ==Provide.value<ChildCtegory>(context).childIndex)?true:false;
    return InkWell(
      onTap: () {
          Provide.value<ChildCtegory>(context).changeChildIndex(index);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28),color: isCilck?Colors.pinkAccent:Colors.black26),
        ),
      ),
    );
  }
}

class CategoreGoodsList extends StatefulWidget {
  CategoreGoodsList({Key key}) : super(key: key);

  _CategoreGoodsListState createState() => _CategoreGoodsListState();
}

class _CategoreGoodsListState extends State<CategoreGoodsList> {
  @override
  Widget build(BuildContext context) {
    return Provide<CateGorygoodsListProvide>(
      builder: (context, child, data) {
        return Expanded(
          child: Container(
            width: ScreenUtil().setWidth(570),
            child: ListView.builder(
              itemCount: data.goodslist.length,
              itemBuilder: (context, index) {
                return _goodsListitem(data.goodslist, index);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _goodsImage(List list, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      decoration: BoxDecoration(color: Colors.green),
    );
  }

  Widget _goodsname(List list, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(300),
      child: Text(
        list[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _goodsPrice(List list, index) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(300),
      child: Row(
        children: <Widget>[
          Text(
            '价格:${list[index].presentPrice}',
            style: TextStyle(
                color: Colors.pinkAccent, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '${list[index].oriPrice}',
            style: TextStyle(
              color: Colors.black26,
              decoration: TextDecoration.lineThrough,
            ),
          )
        ],
      ),
    );
  }

  Widget _goodsListitem(List list, int gindex) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black26, width: 0.8))),
        child: Row(
          children: <Widget>[
            _goodsImage(list, gindex),
            Column(
              children: <Widget>[
                _goodsname(list, gindex),
                _goodsPrice(list, gindex)
              ],
            )
          ],
        ),
      ),
    );
  }
}
