import 'package:dio/dio.dart';
import 'dart:io';
import 'package:async/async.dart';
import '../config/serviceurl.dart';

//获取首页内容
Future getCategorydatas() async{
  print("开始获取");
  
  try{
        Response response;
        Dio dio = Dio();
        dio.options.contentType = ContentType.parse('application/json; charset=utf-8');
   
        response = await dio.get(servicePath['Category']);
        if(response.statusCode == 200){
          print("拿到数据");
              return response.data;
        }else{
          throw  "接口出现异常";
        }
  }catch(e){
    print(e);
  }
}

//获取指定商品
Future getCategorylist() async{
 try{
        Response response;
        Dio dio = Dio();
        dio.options.contentType = ContentType.parse('application/json; charset=utf-8');
   
        response = await dio.get(servicePath['CategoryGoodslist']);
        if(response.statusCode == 200){
          print("拿到数据");
              return response.data;
        }else{
          throw  "接口出现异常";
        }
  }catch(e){
    print(e);
  }

}









