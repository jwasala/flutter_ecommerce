import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/custom_popup_menu_button.dart';
import 'package:flutter_ecommerce/models/category.dart';
import 'package:flutter_ecommerce/pages/article/index.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:provider/provider.dart';

class CategoryIndex extends StatelessWidget {
  const CategoryIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Warzywniak'),
          actions: const [CustomPopupMenuButton()],
        ),
        body: Center(child: Consumer<ShopStore>(builder: (context, shop, child) {
          return ListView(
              children: shop.categories
                  .map((Category category) => Card(
                          child: ListTile(
                        title: Text(category.name),
                        subtitle: Text(category.description),
                        isThreeLine: true,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleIndex(
                                    title: category.name, articles: shop.getArticlesByCategory(category.categoryId)))),
                      )))
                  .toList());
        })));
  }
}
