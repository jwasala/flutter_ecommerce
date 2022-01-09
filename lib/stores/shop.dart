import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/models/category.dart';

class Shop extends ChangeNotifier {
  final List<Article> _articles = [];
  final List<Category> _categories = [];
  final List<CartItem> _cartItems = [];

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);

  UnmodifiableListView<CartItem> get cartItems =>
      UnmodifiableListView(_cartItems);

  double get totalPrice => _cartItems
      .map((cartItem) =>
          cartItem.count *
          _articles
              .firstWhere((article) => article.articleId == cartItem.articleId)
              .price)
      .sum;

  UnmodifiableListView<Article> getArticlesByCategory(int categoryId) {
    return UnmodifiableListView(
        _articles.where((article) => article.categoryId == categoryId));
  }

  Article? getArticleById(int articleId) {
    return _articles
        .firstWhereOrNull((article) => article.articleId == articleId);
  }

  void addToCart(int articleId) {
    Article? article =
        _articles.firstWhereOrNull((article) => article.articleId == articleId);

    if (article == null) {
      return;
    }

    CartItem? cartItem = _cartItems
        .firstWhereOrNull((cartItem) => cartItem.articleId == articleId);

    if (cartItem == null) {
      _cartItems.add(CartItem(articleId, 1));
    } else {
      cartItem.count++;
    }

    notifyListeners();
  }

  void removeFromCart(int articleId) {
    Article? article =
        _articles.firstWhereOrNull((article) => article.articleId == articleId);

    if (article == null) {
      return;
    }

    CartItem? cartItem = _cartItems
        .firstWhereOrNull((cartItem) => cartItem.articleId == articleId);

    if (cartItem != null) {
      if (cartItem.count == 1) {
        _cartItems.removeWhere((cartItem) => cartItem.articleId == articleId);
      } else {
        cartItem.count--;
      }

      notifyListeners();
    }
  }
}
