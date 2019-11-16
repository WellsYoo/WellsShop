import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
import 'package:fluro/fluro.dart';
import './routers/application.dart';
import './routers/routers.dart';

void main() {
  final providers = Providers();
  providers
  ..provide(Provider.function((context)=>Counter()))
  ..provide(Provider.function((context)=>ChildCategory()))
  ..provide(Provider.function((context)=>CategoryGoodsListProvide()));

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}
 
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
          title: 'Wells Shop',
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage()),
    );
  }
}
