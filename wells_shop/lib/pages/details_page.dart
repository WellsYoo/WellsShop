import 'package:flutter/material.dart';
import 'package:wells_shop/pages/details_page/details_web.dart';
import '../provide/details_info.dart';
import 'package:provide/provide.dart';
import './details_page/details_top_ares.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/detail_bottom.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);
  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExpain(),
                      DetailsTabbar(),
                      DetailsWebView()
                    ],
                  ),
                ),

                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailBottom()
                )
              ],
            );
          } else {
            return Text('加载中...');
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);
    return '完成加载';
  }
}
