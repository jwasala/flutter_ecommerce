import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/models/category.dart';

class Article {
  final int articleId;
  final String name;
  final String? description;
  final String imagePath;
  final double price;
  final int categoryId;

  Category? get category => CategoryModel.find(categoryId);

  Article(this.articleId, this.name, this.description, this.imagePath,
      this.price, this.categoryId);
}

class ArticleModel extends ChangeNotifier {
  static final List<Article> _articles = [];

  static Article? find(int id) {
    for (var article in articles) {
      if (article.articleId == id) {
        return article;
      }
    }
    return null;
  }

  static UnmodifiableListView<Article> get articles =>
      UnmodifiableListView(_articles);
}
