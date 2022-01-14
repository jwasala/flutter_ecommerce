import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/pages/article/create.dart';
import 'package:flutter_ecommerce/pages/article/index.dart';
import 'package:flutter_ecommerce/pages/cart/index.dart';
import 'package:flutter_ecommerce/pages/category/index.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:flutter_ecommerce/utils/format.dart';
import 'package:provider/provider.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (result) {
        if (result == 0) {
          Navigator.popUntil(context, (route) => route.isFirst);
        } else if (result == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ArticleIndex(title: 'Ulubione', articles: Provider.of<ShopStore>(context).favorites)));
        } else if (result == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CartIndex()));
        } else if (result == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ArticleCreate()));
        } else if (result == 4) {
          showDialog(
              context: context,
              builder: (_) => const AlertDialog(
                    title: Text('Warzywniak Online'),
                    content: Text('2022 © Jakub Wąsala'),
                  ));
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(child: ListTile(leading: Icon(Icons.home), title: Text('Strona główna')), value: 0),
        const PopupMenuDivider(),
        PopupMenuItem<int>(
            child: ListTile(
                leading: Consumer<ShopStore>(
                  builder: (context, shop, child) {
                    if (shop.favorites.isEmpty) {
                      return const Icon(Icons.favorite);
                    } else {
                      return Badge(
                          badgeContent:
                              Text(shop.favorites.length.toString(), style: const TextStyle(color: Colors.white)),
                          child: const Icon(Icons.favorite));
                    }
                  },
                ),
                title: const Text('Ulubione')),
            value: 1),
        PopupMenuItem<int>(
            child: ListTile(
                leading: Consumer<ShopStore>(
                  builder: (context, shop, child) {
                    if (shop.cartItems.isEmpty) {
                      return const Icon(Icons.shopping_cart);
                    } else {
                      return Badge(
                          badgeContent:
                              Text(shop.cartItems.length.toString(), style: const TextStyle(color: Colors.white)),
                          child: const Icon(Icons.shopping_cart));
                    }
                  },
                ),
                title: const Text('Koszyk')),
            value: 2),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          child: ListTile(
            leading: Icon(Icons.add),
            title: Text('Dodaj artykuł')
          ),
          value: 3,
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<int>(
          child: ListTile(leading: Icon(Icons.info), title: Text('O aplikacji')),
          value: 4,
        )
      ],
    );
  }
}
