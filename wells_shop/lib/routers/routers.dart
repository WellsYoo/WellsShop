import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routers {
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ERROR===>Route WAS NOT FOUND!');
        return Container(
          child: Center(
            child: Text('ERROR===>Route WAS NOT FOUND!'),
          ),
        );
      }
    );
    router.define(detailsPage, handler: detailsHandler);
  }
}