import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = SharedPreferences.getInstance();
  }
}