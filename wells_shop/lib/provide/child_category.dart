import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  setChildCategoryList(List list){
    childCategoryList = list;
    notifyListeners();
  }
}