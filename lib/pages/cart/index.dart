import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/custom_popup_menu_button.dart';
import 'package:flutter_ecommerce/models/cart_item.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:flutter_ecommerce/utils/format.dart';
import 'package:provider/provider.dart';

class CartIndex extends StatelessWidget {
  const CartIndex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text('Koszyk'),
          actions: const [CustomPopupMenuButton()],
        ),
        body: Consumer<ShopStore>(
          builder: (context, shop, child) {
            return ListView(
                children: shop.cartItems
                    .map((CartItem cartItem) => Card(
                          child: ListTile(
                            leading: Image.asset(shop.getArticleById(cartItem.articleId).assets[0]),
                            title: Text(shop.getArticleById(cartItem.articleId).name),
                            subtitle: Text(
                                toMonetaryFormatAlt(shop.getArticleById(cartItem.articleId).price * cartItem.count)),
                            trailing: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      bool isGoingToBeDeleted = cartItem.count == 1;
                                      shop.removeFromCart(cartItem.articleId);

                                      if (isGoingToBeDeleted) {
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: const Text('Artykuł został usunięty z koszyka'),
                                          action: SnackBarAction(
                                              label: 'Cofnij',
                                              onPressed: () {
                                                Provider.of<ShopStore>(context, listen: false)
                                                    .addToCart(cartItem.articleId);
                                              }),
                                        ));
                                      }
                                    },
                                    icon: const Icon(Icons.remove)),
                                Text('${cartItem.count} kg', style: const TextStyle(fontSize: 16)),
                                IconButton(
                                    onPressed: () {
                                      shop.addToCart(cartItem.articleId);
                                    },
                                    icon: const Icon(Icons.add)),
                              ],
                            ),
                          ),
                        ))
                    .toList());
          },
        ),
        floatingActionButton: Consumer<ShopStore>(builder: (context, shop, child) {
          return FloatingActionButton.extended(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => const AlertDialog(
                      title: Text('Błąd'), content: Text('Ta funkcja nie została jeszcze zaimplementowana')));
            },
            label: Text('Zamawiam za ${toMonetaryFormatAlt(shop.totalPrice)}'),
            icon: const Icon(Icons.payments),
          );
        }));
  }
}
