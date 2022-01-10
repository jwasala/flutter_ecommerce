import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_ecommerce/components/custom_carousel.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:provider/provider.dart';

import '../../settings.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  void onPressedFavoriteButton(BuildContext context, Shop shop) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (shop.isArticleFavorite(article.articleId)) {
      shop.removeFromFavorites(article.articleId);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Usunięto z ulubionych')));
    } else {
      shop.addToFavorites(article.articleId);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Dodano do ulubionych')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.name),
          actions: [
            Consumer<Shop>(
              builder: (context, shop, child) {
                return IconButton(
                    onPressed: () => onPressedFavoriteButton(context, shop),
                    icon: Icon(shop.isArticleFavorite(article.articleId)
                        ? Icons.favorite
                        : Icons.favorite_border));
              },
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: Column(children: [
          CustomCarousel(assets: article.assets),
          Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                  '${article.price.toStringAsFixed(2)} ${Settings.currency}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)))
        ]));
  }
}
