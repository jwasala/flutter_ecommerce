import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/models/category.dart';

class Shop extends ChangeNotifier {
  final List<Article> _articles = [
    Article(1, 'Kalafior', ['apple.jpg'], 3.50, 1),
    Article(2, 'Ziemniaki', ['apple.jpg'], 3.50, 1),
    Article(3, 'Sałata', ['apple.jpg'], 3.50, 1),
    Article(4, 'Jabłka', ['apple.jpg'], 3.50, 2),
    Article(5, 'Cytryna', ['lime.jpg'], 3.50, 2),
    Article(6, 'Gruszki', ['pear.jpg', 'pear_2.jpg', 'pear_3.webp'], 3.50, 2),
    Article(6, 'Mandarynki', ['tangerine.jfif'], 3.50, 2),
    Article(7, 'Rodzynki', ['apple.jpg'], 3.50, 3),
    Article(8, 'Żurawina', ['apple.jpg'], 3.50, 3),
    Article(9, 'Pistacje', ['apple.jpg'], 3.50, 3),
  ];
  final List<Category> _categories = [
    Category(1, 'Warzywa'),
    Category(2, 'Owoce'),
    Category(3, 'Bakalie')
  ];
  final List<CartItem> _cartItems = [];
  final Set<int> _favoriteArticlesIds = {};

  bool isArticleFavorite(int articleId) {
    return _favoriteArticlesIds.contains(articleId);
  }

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

  void addToFavorites(int articleId) {
    _favoriteArticlesIds.add(articleId);
    notifyListeners();
  }

  void removeFromFavorites(int articleId) {
    _favoriteArticlesIds.remove(articleId);
    notifyListeners();
  }
}
