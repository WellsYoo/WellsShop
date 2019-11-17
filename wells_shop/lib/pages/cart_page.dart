import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> testList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
//增加，修改
  void _add() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String temp = '维他ViTa';
    testList.add(temp);
    prefs.setStringList('testKey', testList);
  }

//查询
  void _show() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getStringList('testKey') != null) {
      setState(() {
        testList = prefs.getStringList("testKey");
      });
    }
  }

//删除
void _clear() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('testKey');
  setState(() {
    testList = [];
  });
}
}