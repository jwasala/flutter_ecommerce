import 'dart:collection';

import 'package:flutter/cupertino.dart';

class Article {
  final int articleId;
  final String name;
  final String? description;
  final String imagePath;
  final double price;
  final int categoryId;

  Article(this.articleId, this.name, this.description, this.imagePath,
      this.price, this.categoryId);
}

class ArticleModel extends ChangeNotifier {
  final List<Article> _articles = [];

  Article? find(int id) {
    for (var article in articles) {
      if (article.articleId == id) {
        return article;
      }
    }
    return null;
  }

  UnmodifiableListView<Article> get articles => UnmodifiableListView(_articles);
}
