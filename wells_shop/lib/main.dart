import 'package:flutter/material.dart';
import './pages/index_page.dart';
import 'package:provide/provide.dart';
import './provide/counter.dart';
import './provide/child_category.dart';

void main() {
  // var counter = Counter();
  final providers = Providers();
  providers
  ..provide(Provider.function((context)=>Counter()))
  ..provide(Provider.function((context)=>ChildCategory()));
  runApp(ProviderNode(
    child: MyApp(),  
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: 'Wells Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
          home: IndexPage()
      ),
    );
  }
}
