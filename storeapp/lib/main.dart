import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './pages/Index_page.dart';
import 'config/ServiceLocator.dart';
import 'package:provide/provide.dart';
import './provide/Counter.dart';
import './provide/catagorychild.dart';
import './provide/Category_goodsList.dart';

void main() {
  Counter counter = Counter();
  ChildCtegory childctegory = ChildCtegory();
  CateGorygoodsListProvide cateGorygoodsListProvide =
      CateGorygoodsListProvide();
  Providers providers = Providers(); //状态管理
  providers
    ..provide(Provider<Counter>.value(counter)) //注册状态管理
    ..provide(Provider<ChildCtegory>.value(childctegory))
    ..provide(
        Provider<CateGorygoodsListProvide>.value(cateGorygoodsListProvide));
  setupLocator();
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "商店APP",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(accentColor: Colors.greenAccent),
        home: IndexPage(),
      ),
    );
  }
}
