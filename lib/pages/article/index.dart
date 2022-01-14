import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/custom_popup_menu_button.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/pages/article/detail.dart';
import 'package:flutter_ecommerce/utils/format.dart';

class ArticleIndex extends StatelessWidget {
  final String title;
  final List<Article> articles;

  const ArticleIndex({Key? key, required this.title, required this.articles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const [CustomPopupMenuButton()],
      ),
      body: Center(
          child: ListView(
        children: articles
            .map((Article article) => Card(
                    child: ListTile(
                  leading: Image.asset(article.assets[0]),
                  title: Text(article.name),
                  subtitle: Text(toMonetaryFormat(article.price)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ArticleDetail(article: article))),
                )))
            .toList(),
      )),
    );
  }
}
