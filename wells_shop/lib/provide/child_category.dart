import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;  //右侧导航索引
  String categoryId = '4'; //大类
  String subId = '';  //小类
  int page = 1;
  String noMoreText = '';

  setChildCategoryList(List<BxMallSubDto> list, String categoryId){
    childIndex = 0;
    categoryId = categoryId;
    page = 1;
    noMoreText = '';

    BxMallSubDto all = BxMallSubDto();
    all.mallCategoryId = '00';
    all.mallSubId = '';
    all.comments = 'null';
    all.mallSubName = '全部';
    childCategoryList = [all];
    var list2 = list;
    childCategoryList.addAll(list2);
    notifyListeners();
  }

  changeChildIndex(index, subId) {
    childIndex = index;
    this.subId = subId;
    page = 1;
    noMoreText = '';
    notifyListeners(); 
  }

  nextPage(){
    page ++;
  }

  setNoMoreText(String noMoreText){
    noMoreText = noMoreText;
    notifyListeners();
  }
}