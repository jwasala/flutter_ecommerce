import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/article.dart';

class CartItem {
  final int articleId;
  final int count;

  Article? get article => ArticleModel.find(articleId);

  CartItem(this.articleId, this.count);
}

class Cart {
  final Iterable<CartItem> items;

  Cart(this.items);
}

class CartModel extends ChangeNotifier {
  static final Cart _cart = Cart([]);

  static Cart get cart => _cart;
}
