import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/models/category.dart';

class ShopStore extends ChangeNotifier {
  List<Article> _articles = [
    Article(1, 'Kalafior', ['assets/apple.jpg'], 3.50, 1),
    Article(2, 'Ziemniaki', ['assets/apple.jpg'], 3.50, 1),
    Article(3, 'Sałata', ['assets/apple.jpg'], 3.50, 1),
    Article(4, 'Jabłka', ['assets/apple.jpg'], 3.50, 2),
    Article(5, 'Limonka', ['assets/lime.jpg'], 3.50, 2),
    Article(6, 'Gruszki', ['assets/pear.jpg', 'assets/pear_2.jpg', 'assets/pear_3.webp'], 3.50, 2),
    Article(7, 'Mandarynki', ['assets/tangerine.jfif'], 3.50, 2),
    Article(8, 'Rodzynki', ['assets/apple.jpg'], 3.50, 3),
    Article(9, 'Żurawina', ['assets/apple.jpg'], 3.50, 3),
    Article(10, 'Pistacje', ['assets/apple.jpg'], 3.50, 3),
    Article(11, 'Kalafior', ['assets/apple.jpg'], 3.50, 1),
    Article(12, 'Ziemniaki', ['assets/apple.jpg'], 3.50, 1),
    Article(13, 'Sałata', ['assets/apple.jpg'], 3.50, 1),
    Article(14, 'Jabłka', ['assets/apple.jpg'], 3.50, 2),
    Article(15, 'Limonka', ['assets/lime.jpg'], 3.50, 2),
    Article(16, 'Gruszki', ['assets/pear.jpg', 'assets/pear_2.jpg', 'assets/pear_3.webp'], 3.50, 2),
    Article(17, 'Mandarynki', ['assets/tangerine.jfif'], 3.50, 2),
    Article(18, 'Rodzynki', ['assets/apple.jpg'], 3.50, 3),
    Article(19, 'Żurawina', ['assets/apple.jpg'], 3.50, 3),
    Article(20, 'Pistacje', ['assets/apple.jpg'], 3.50, 3),
    Article(21, 'Kalafior', ['assets/apple.jpg'], 3.50, 1),
    Article(22, 'Ziemniaki', ['assets/apple.jpg'], 3.50, 1),
    Article(23, 'Sałata', ['assets/apple.jpg'], 3.50, 1),
    Article(24, 'Jabłka', ['assets/apple.jpg'], 3.50, 2),
    Article(25, 'Limonka', ['assets/lime.jpg'], 3.50, 2),
    Article(26, 'Gruszki', ['assets/pear.jpg', 'assets/pear_2.jpg', 'assets/pear_3.webp'], 3.50, 2),
    Article(27, 'Mandarynki', ['assets/tangerine.jfif'], 3.50, 2),
    Article(28, 'Rodzynki', ['assets/apple.jpg'], 3.50, 3),
    Article(29, 'Żurawina', ['assets/apple.jpg'], 3.50, 3),
    Article(30, 'Pistacje', ['assets/apple.jpg'], 3.50, 3),
  ];
  final List<Category> _categories = [
    Category(1, 'Warzywa', 'Świeże warzywa z krajowych upraw, tylko ekologiczni dostawcy.'),
    Category(2, 'Owoce', 'Źródła wielu witamin. Dostępne wiele krajowych i importowanych produktów.'),
    Category(3, 'Bakalie', 'Suszone owoce południowe i orzechy, świetne m.in. jako dodatek do ciast.')
  ];
  List<CartItem> _cartItems = [];
  final Set<int> _favoriteArticlesIds = {};

  bool isArticleFavorite(int articleId) {
    return _favoriteArticlesIds.contains(articleId);
  }

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);

  UnmodifiableListView<Article> get favorites =>
      UnmodifiableListView(_articles.where((article) => isArticleFavorite(article.articleId)));

  UnmodifiableListView<Category> get categories => UnmodifiableListView(_categories);

  UnmodifiableListView<CartItem> get cartItems => UnmodifiableListView(_cartItems);

  int get nextArticleId =>
      articles.map((article) => article.articleId).reduce((value, element) => max(value, element)) + 1;

  int get nextCategoryId =>
      categories.map((category) => category.categoryId).reduce((value, element) => max(value, element)) + 1;

  double get totalPrice => _cartItems
      .map((cartItem) =>
          cartItem.count * _articles.firstWhere((article) => article.articleId == cartItem.articleId).price)
      .sum;

  UnmodifiableListView<Article> getArticlesByCategory(int categoryId) {
    return UnmodifiableListView(_articles.where((article) => article.categoryId == categoryId));
  }

  Article getArticleById(int articleId) {
    return _articles.firstWhere((article) => article.articleId == articleId);
  }

  void addToCart(int articleId) {
    Article? article = _articles.firstWhereOrNull((article) => article.articleId == articleId);

    if (article == null) {
      return;
    }

    CartItem? cartItem = _cartItems.firstWhereOrNull((cartItem) => cartItem.articleId == articleId);

    if (cartItem == null) {
      _cartItems.add(CartItem(articleId, 1));
    } else {
      cartItem.count++;
    }

    notifyListeners();
  }

  void removeFromCart(int articleId) {
    Article? article = _articles.firstWhereOrNull((article) => article.articleId == articleId);

    if (article == null) {
      return;
    }

    CartItem? cartItem = _cartItems.firstWhereOrNull((cartItem) => cartItem.articleId == articleId);

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

  int addArticle(String name, double price, int categoryId) {
    var nextId = nextArticleId;
    var article = Article(nextArticleId, name, ['assets/placeholder.png'], price, categoryId);
    _articles.add(article);
    notifyListeners();
    return nextId;
  }

  void deleteArticle(int articleId) {
    _favoriteArticlesIds.remove(articleId);
    _cartItems = _cartItems.where((element) => element.articleId != articleId).toList();
    _articles = _articles.where((element) => element.articleId != articleId).toList();
    notifyListeners();
  }
}
