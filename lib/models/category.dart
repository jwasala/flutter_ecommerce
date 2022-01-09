import 'dart:collection';

import 'package:flutter/cupertino.dart';

class Category {
  final int categoryId;
  final String name;

  Category(this.categoryId, this.name);
}

class CategoryModel extends ChangeNotifier {
  static final List<Category> _categories = [
    Category(1, 'Warzywa'),
    Category(2, 'Owoce'),
    Category(3, 'Bakalie')
  ];

  static Category? find(int id) {
    for (var category in categories) {
      if (category.categoryId == id) {
        return category;
      }
    }
    return null;
  }

  static UnmodifiableListView<Category> get categories =>
      UnmodifiableListView(_categories);
}
