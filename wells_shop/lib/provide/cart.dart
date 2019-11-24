import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList=[];
   double allPrice =0 ;   //总价格
  int allGoodsCount =0;  //商品总数量
  bool isAllCheck= true; //是否全选

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList =  (temp as List).cast();
    cartList = [];
    tempList.forEach((item){
      cartList.add(CartInfoModel.fromJson(item));
    });
    bool isHave = false;
    int ival = 0;
    cartList.forEach((item) {
      if (item.goodsId == goodsId) {
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true //是否已经选择
      };
      cartList.add(new CartInfoModel.fromJson(newGoods));
    }

    cartString = json.encode(cartList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

//删除购物车中的商品
  remove() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();//清空键值对
    prefs.remove('cartInfo');
    cartList=[];
    allPrice =0 ;
    allGoodsCount=0;
    print('清空完成-----------------');
    notifyListeners();
  }

  //得到购物车中的商品
  getCartInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //获得购物车中的商品,这时候是一个字符串
     cartString=prefs.getString('cartInfo'); 
     
     //把cartList进行初始化，防止数据混乱 
     cartList=[];
     //判断得到的字符串是否有值，如果不判断会报错
     if(cartString==null){
       cartList=[];
     }else{
       List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
       allPrice=0;
       allGoodsCount=0;
       isAllCheck=true;
       tempList.forEach((item){
        
          if(item['isCheck']){
             allPrice+=(item['count']*item['price']);
             allGoodsCount+=item['count'];
          }else{
            isAllCheck=false;
          }
         
          cartList.add(new CartInfoModel.fromJson(item));

       });

     }
      notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo'); 
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
   
     int tempIndex =0;
     int delIndex=0;
     tempList.forEach((item){
         
         if(item['goodsId']==goodsId){
          delIndex=tempIndex;
         }
         tempIndex++;
     });
      tempList.removeAt(delIndex);
      cartString= json.encode(tempList).toString();
      prefs.setString('cartInfo', cartString);//
      await getCartInfo();
     

  }

  //修改选中状态
  changeCheckState(CartInfoModel cartItem) async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     cartString=prefs.getString('cartInfo'); 
     List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
     int tempIndex =0;
     int changeIndex=0;
     tempList.forEach((item){
         
         if(item['goodsId']==cartItem.goodsId){
          changeIndex=tempIndex;
         }
         tempIndex++;
     });
     tempList[changeIndex]=cartItem.toJson();
     cartString= json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();
    
  }

  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    List<Map> newList=[];
    for(var item in tempList ){
      var newItem = item;
      newItem['isCheck']=isCheck;
      newList.add(newItem);
    } 
   
     cartString= json.encode(newList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();

  }

  //增加减少数量的操作

  addOrReduceAction(var cartItem, String todo )async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString=prefs.getString('cartInfo'); 
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();
    int tempIndex =0;
    int changeIndex=0;
    tempList.forEach((item){
         if(item['goodsId']==cartItem.goodsId){
          changeIndex=tempIndex; 
         }
         tempIndex++;
     });
     if(todo=='add'){
       cartItem.count++;
     }else if(cartItem.count>1){
       cartItem.count--;
     }
     tempList[changeIndex]=cartItem.toJson();
     cartString= json.encode(tempList).toString();
     prefs.setString('cartInfo', cartString);//
     await getCartInfo();

  }
}
