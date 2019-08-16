import 'package:flutter/material.dart';
import 'Home_Page.dart';
import 'category_page.dart';
import 'Cart_page.dart';
import 'member_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottombars = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
    BottomNavigationBarItem(icon: Icon(Icons.category), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text("ds车")),
    BottomNavigationBarItem(
        icon: Icon(Icons.portable_wifi_off), title: Text("会dsd员")),
  ];
  final List<Widget> pages = [HomePage(), CategoryPage(), CartPage(), MemberPage()];
  int _curindex= 0;
  @override
  Widget build(BuildContext context) {
     ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    return Scaffold(
      body:   
      IndexedStack(     //页面层叠,防止页面切换时刷新
        index:  _curindex,
        children: pages
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottombars,
        currentIndex: _curindex,    
        fixedColor: Colors.pinkAccent,
        onTap: (index){
          setState(() {
           this._curindex=index; 
          });
        },
      ),
    );
  }
}
