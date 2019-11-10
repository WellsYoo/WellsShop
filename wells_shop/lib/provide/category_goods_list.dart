import 'package:flutter/material.dart';
import '../model/category_goods_list.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  setGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }

  setMoreGoodsList(List<CategoryListData> list) {
    goodsList.addAll(list);
    notifyListeners();
  }
}
