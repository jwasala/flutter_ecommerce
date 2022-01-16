import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/custom_popup_menu_button.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/pages/article/detail.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:flutter_ecommerce/utils/format.dart';
import 'package:provider/provider.dart';

class ArticleDelete extends StatefulWidget {
  const ArticleDelete({Key? key}) : super(key: key);

  @override
  State<ArticleDelete> createState() => _ArticleDeleteState();
}

class _ArticleDeleteState extends State<ArticleDelete> {
  final List<int> _checkedIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Usuwanie artykułów"),
        actions: const [CustomPopupMenuButton()],
      ),
      body: () {
        if (Provider.of<ShopStore>(context).articles.isNotEmpty) {
          return Center(
              child: ListView(
                  children: Provider.of<ShopStore>(context).articles
                      .map((Article article) => Card(
                      child: ListTile(
                        leading: Image.asset(article.assets[0]),
                        title: Text(article.name),
                        subtitle: Text(toMonetaryFormat(article.price)),
                        trailing: Checkbox(value: _checkedIds.contains(article.articleId), onChanged: (bool? value) {
                          if (value == true) {
                            setState(() {
                              _checkedIds.add(article.articleId);
                            });
                          } else if (value == false) {
                            setState(() {
                              _checkedIds.remove(article.articleId);
                            });
                          }
                        },),
                        onTap: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ArticleDetail(article: article))),
                      )))
                      .toList()));
        } else {
          return Container(
            alignment: Alignment.center,
            child: EmptyWidget(
              image: null,
              packageImage: PackageImage.Image_3,
              title: 'Brak artykułów',
              subTitle: '.',
              titleTextStyle: const TextStyle(
                fontSize: 18,
                color: Color(0xff9da9c7),
                fontWeight: FontWeight.w500,
              ),
              subtitleTextStyle: const TextStyle(
                fontSize: 12,
                color: Color(0xffabb8d6),
              ),
            ),
          );
        }
      }(),
      floatingActionButton: () {
        if (_checkedIds.isEmpty) {
          return null;
        }

        return Consumer<ShopStore>(builder: (context, shop, child) {
          var len = _checkedIds.length;
          String articleLocal = "artykuł";
          if (1 < len && len < 5) {
            articleLocal = "artykuły";
          } else if (len >= 5) {
            articleLocal = "artykułów";
          }
          return FloatingActionButton.extended(onPressed: (){
            for (var id in _checkedIds) {
              shop.deleteArticle(id);
            }

            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Usunięcie zakończone powodzeniem'),
                  content: Text('Usunięto $len $articleLocal'),
                ));

          }, label: Text('Usuń $len $articleLocal'));
        },);
      }(),
    );
  }
}
