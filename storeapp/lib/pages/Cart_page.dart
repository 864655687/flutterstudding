import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/Counter.dart';



class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Number(),
           MyButton()
         ],
       ),
    );
  }
}



class Number extends StatelessWidget {
  const Number({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Counter>(
        builder: (context,child,counter){
          return Text("${counter.value}",
            style: Theme.of(context).textTheme.display1);
          
        },
      )
    );
  }
}


class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          Provide.value<Counter>(context).increment();
        
        },
        child: Text("计数"),
      ),
    );
  }
}