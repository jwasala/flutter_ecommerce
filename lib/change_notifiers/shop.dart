import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/models/category.dart';

class ShopChangeNotifier extends ChangeNotifier {
  final List<Article> _articles = [];
  final List<Category> _categories = [];
  final List<CartItem> _cartItems = [];
}
