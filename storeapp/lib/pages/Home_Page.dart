import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config/httpHeaders.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../config/ServiceLocator.dart';
import '../config/TelAndSmsService.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  //保持当前页面状态  不会刷新
  int page = 1;

  List<Map> hotGoodslist = [
    {},
    {},
  ];
  // 没有Key时加上  GlobalKey<RefreshFooterState> _footerkey = GlobalKey<RefreshFooterState>();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print("来到拉新页面");
    print(hotGoodslist.length);
    hotGoodslist = [
      {"img": "images/1.jpg", "title": "美食"},
      {"img": "images/2.jpg", "title": "影视"},
      {"img": "images/3.jpg", "title": "游戏"},
      {"img": "images/2.jpg", "title": "影视"},
    ];
    super.initState();
  }

  String showtext = "4324s";
  List pics = [
    "images/1.jpg",
    "images/2.jpg",
    "images/3.jpg",
  ];
  List items = [
    {"img": "images/1.jpg", "title": "美食"},
    {"img": "images/2.jpg", "title": "影视"},
    {"img": "images/3.jpg", "title": "游戏"},
    {"img": "images/2.jpg", "title": "影视"},
    {"img": "images/3.jpg", "title": "游戏"},
    {"img": "images/2.jpg", "title": "影视"},
    {"img": "images/3.jpg", "title": "游戏"},
    {"img": "images/3.jpg", "title": "游戏"},
    {"img": "images/2.jpg", "title": "影视"},
    {"img": "images/3.jpg", "title": "游戏"},
  ];
  String leaderimg = "images/2.jpg";

  void startgetdatas() {
    gethttp().then((v) {
      setState(() {
        this.showtext = v['data']['nav'].toString();
      });
    });
  }

  Future gethttp() async {
    try {
      Response response;
      Dio dio = Dio();
      dio.options.headers = httpHeaders; //伪造请求头 ,获取远程数据

      response =
          await dio.post("https://time.geekbang.org/serv/v1/column/newAll");
      print(response);
      return response.data;
    } catch (e) {
      return print(e);
    }
  }

  bool flag =false ;
  EasyRefreshController _controller = EasyRefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText: "bvcbc"),
        ),
        backgroundColor: Colors.orangeAccent,
      ),
      body: EasyRefresh(
        controller: _controller,
        header: ClassicalHeader(
          bgColor: Colors.pinkAccent,
          textColor: Colors.purple,
          noMoreText: "没有东西",
          showInfo: true,
          refreshingText: "正在刷新",
        ),
        footer: ClassicalFooter(
          enableInfiniteLoad: false,
          loadText: "上拉加载跟多数据",
          infoText: "下拉加载更多",
          loadingText: "正在加载数据",
          loadReadyText: "释放加载数据",
          noMoreText: "没有更多数据",
          loadedText: "加载完成",
          bgColor: Colors.greenAccent,
          showInfo: false,
        ),
        child: ListView(
          children: <Widget>[
            SwiperWidget(pics: this.pics),
            TopnavigatorBar(items: this.items),
            Adbanner(
              adurl: items[1]['img'],
            ),
            LeaderPhone(
              leaderImg: this.leaderimg,
            ),
            ProdcutRecomemd(
              pics: this.pics,
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            FloorTitle(),
            _hotGoods()
          ],
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            print("开始刷新");
          });
        },
      
        onLoad: () async {
            
          await Future.delayed(Duration(seconds: 2), () {
            print("开始加载更多");
       
     Fluttertoast.showToast(
              msg:"没有更多啦",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER
              );
              _controller.finishLoad(success: true);
              flag = !flag;
          

            // setState(() {
            //   hotGoodslist.add({});
            // });
          });
        },
      ),
    );
  }

  Widget hottile = Container(
    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text("火爆专区"),
  );

  Widget _warpList() {
    if (page != 0) {
      List<Widget> listWidget = hotGoodslist.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: ScreenUtil().setWidth(370),
            color: Colors.blueAccent,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "images/3.jpg",
                  width: ScreenUtil().setWidth(365),
                ),
                Text("火爆列表的商品",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: ScreenUtil().setSp(24))),
                Row(
                  children: <Widget>[
                    Text("2600元"),
                    Text(
                      "3500元",
                      style: TextStyle(
                          fontSize: 25.0, decoration: TextDecoration.underline),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(spacing: 2, children: listWidget);
    } else {
      return Text("没有数据");
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hottile,
          _warpList(),
        ],
      ),
    );
  }
}

//轮播
class SwiperWidget extends StatelessWidget {
  const SwiperWidget({
    Key key,
    @required this.pics,
  }) : super(key: key);

  final List pics;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(300),
      child: Swiper(
        itemCount: this.pics.length,
        itemBuilder: (BuildContext ctx, int index) {
          return InkWell(
            child: Image.asset(
              this.pics[index],
              fit: BoxFit.cover,
            ),
            onTap: () {
              print(index);
            },
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

//分类导航
class TopnavigatorBar extends StatelessWidget {
  final List items;
  TopnavigatorBar({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(280),
      padding: EdgeInsets.all(10.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(), //静止view滚动
        crossAxisCount: 5,
        //  mainAxisSpacing:20.0 ,
        children: items.map((val) {
          return _gridview(context, val);
        }).toList(),
      ),
    );
  }

  Widget _gridview(BuildContext context, val) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Image.asset(
            val['img'],
            width: ScreenUtil().setWidth(95),
            height: ScreenUtil().setHeight(70.0),
          ),
          Text(val['title'])
        ],
      ),
      onTap: () {
        print("点击页面跳转");
      },
    );
  }
}

//广告
class Adbanner extends StatelessWidget {
  final String adurl;

  const Adbanner({Key key, this.adurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(100),
      width: ScreenUtil().setWidth(1334),
      child: Image.asset(
        adurl,
        fit: BoxFit.fill,
      ),
    );
  }
}

//电话
class LeaderPhone extends StatelessWidget {
  final String leaderImg;
  final String phonenumber;
  final String number = "13592134991606";
  final TelAndSmsServiece _serviece = locator<TelAndSmsServiece>();
  LeaderPhone({Key key, this.leaderImg, this.phonenumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: InkWell(
        child: Image.asset(
          this.leaderImg,
          fit: BoxFit.fill,
        ),
        onTap: () => _serviece.call("15025706820"), //_launchURL,
      ),
    );
  }

  // void _launchURL() async {

  //   try {
  //       print("laugnch");
  //     String  url = 'tel:'+this.phonenumber;
  //     if (await canLaunch(url)) {
  //       await launch(url);
  //     } else {
  //       throw "url不能进行访问========>异常";
  //     }
  //   } catch (e) {
  //     print("有错误:=========>" + e);
  //   }
  // }
}

//推荐
class ProdcutRecomemd extends StatelessWidget {
  final List pics;
  const ProdcutRecomemd({Key key, this.pics}) : super(key: key);

  Widget producttitle(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      height: ScreenUtil().setHeight(100.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Colors.black26, width: 0.4))),
      child: Text(
        "商品图片",
        style: TextStyle(fontSize: 18.0, color: Colors.pinkAccent),
      ),
    );
  }

  Widget produtitem(BuildContext context, index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(380),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.only(top: 8.0, left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black26))),
        child: Column(
          children: <Widget>[
            Container(
                height: ScreenUtil().setHeight(250),
                child: Image.asset(
                  this.pics[index],
                  fit: BoxFit.fill,
                )),
            Text("2000元"),
            Text(
              "3800元",
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget retconmedlist(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(330),
        child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return produtitem(context, index); //produtitem(context, index);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          producttitle(context),
          retconmedlist(context)
          //  retconmedlist(context)
        ],
      ),
    );
  }
}

//商品展示
class FloorTitle extends StatelessWidget {
  final String picurl;

  const FloorTitle({Key key, this.picurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _goodsItem(),
        Column(
          children: <Widget>[
            _goodsItem(),
            _goodsItem(),
          ],
        )
      ],
    );
  }

  Widget _goodsItem() {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {},
        child: Image.asset(
          "images/1.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[_goodsItem(), _goodsItem()],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController typecontroller = TextEditingController();
//   var showtext = "welcometo eat";
//   var datas;

//   void _choseiceAction() {
//     print("chosing");
//     if (typecontroller.text.toString() == '') {
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: Text("不能为空"),
//               ));
//     } else {
//       postinfo(typecontroller.text.toString()).then((val) {
//         setState(() {
//           this.showtext = val['data']['name'];
//         });
//       });
//     }
//   }

//   Future getinfo() async {  //dioget 请求
//     try {
//       Response response;
//       response = await Dio().get("https://www.tianqiapi.com/api/");

//       return response.data;
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future postinfo(String text) async {  //dio post请求
//     try {
//       Response response;
//       var data = {'name': text};
//       response = await Dio().post(
//           "https://easy-mock.com/mock/5d53c96db4cb465d92ab63ca/example/flutter_post",
//           queryParameters: data);
//       return response.data;
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(postinfo("dsad").then((v) => print(v)));

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("fsd"),
//       ),
//       body: SingleChildScrollView(
//         //在有表单的页面加上此组件,防止键盘弹出布局溢出
//         child: Center(
//           child: Column(
//             children: <Widget>[
//               TextField(
//                 controller: typecontroller,
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(10.0),
//                     labelText: "吃饭",
//                     helperText: "请输入喜欢吃的菜"),
//                 autofocus: false,
//               ),
//               RaisedButton(
//                 onPressed: () {
//                   _choseiceAction();
//                 },
//                 child: Text("请选择"),
//               ),
//               Text(
//                 showtext,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
