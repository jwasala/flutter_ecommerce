import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/category/index.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ShopStore(),
    child: MaterialApp(
      title: 'Warzywniak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CategoryIndex(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
