import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/custom_carousel.dart';
import 'package:flutter_ecommerce/components/custom_popup_menu_button.dart';
import 'package:flutter_ecommerce/models/article.dart';
import 'package:flutter_ecommerce/pages/cart/index.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:flutter_ecommerce/utils/format.dart';
import 'package:provider/provider.dart';

class ArticleDetail extends StatelessWidget {
  final Article article;

  const ArticleDetail({Key? key, required this.article}) : super(key: key);

  void onPressedFavoriteButton(BuildContext context, ShopStore shop) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (shop.isArticleFavorite(article.articleId)) {
      shop.removeFromFavorites(article.articleId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Usunięto z ulubionych')));
    } else {
      shop.addToFavorites(article.articleId);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dodano do ulubionych')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.name),
        actions: [
          Consumer<ShopStore>(
            builder: (context, shop, child) {
              return IconButton(
                  onPressed: () => onPressedFavoriteButton(context, shop),
                  icon: Icon(shop.isArticleFavorite(article.articleId) ? Icons.favorite : Icons.favorite_border));
            },
          ),
          const CustomPopupMenuButton()
        ],
      ),
      body: Column(children: [
        CustomCarousel(assets: article.assets),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
          child: Row(
            children: [
              Text(
                article.name,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                toMonetaryFormat(article.price),
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Provider.of<ShopStore>(context, listen: false).addToCart(article.articleId);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Dodano do koszyka'),
                  action: SnackBarAction(
                      label: 'Koszyk',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartIndex()));
                      }),
                ));
              },
              child: Text('Dodaj do koszyka'.toUpperCase(), style: const TextStyle(fontSize: 18, letterSpacing: 1)),
              style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: const EdgeInsets.only(top: 25, bottom: 25),
                  shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero)),
            ),
          ),
        )
      ]),
    );
  }
}
