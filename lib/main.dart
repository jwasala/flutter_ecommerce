import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/category/index.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Shop(),
    child: MaterialApp(
      title: 'Warzywniak',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const CategoryIndex(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
