import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/components/custom_popup_menu_button.dart';
import 'package:flutter_ecommerce/pages/article/detail.dart';
import 'package:flutter_ecommerce/pages/cart/index.dart';
import 'package:flutter_ecommerce/stores/shop.dart';
import 'package:provider/provider.dart';

class ArticleCreate extends StatefulWidget {
  const ArticleCreate({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleCreateState();
}

class _ArticleCreateState extends State<ArticleCreate> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  int _categoryIdController = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dodaj artykuł'),
        actions: const [CustomPopupMenuButton()],
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Jabłka', labelText: 'Nazwa artykułu')),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  decoration: const InputDecoration(hintText: '5.50', labelText: 'Cena za kg'),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  hint: const Text('Kategoria'),
                  items: Provider.of<ShopStore>(context)
                      .categories
                      .map((category) => DropdownMenuItem(
                            child: Text(category.name),
                            value: category.categoryId,
                          ))
                      .toList(),
                  onChanged: (int? value) {
                    _categoryIdController = value ?? 1;
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        var id = Provider.of<ShopStore>(context, listen: false).addArticle(
                            _nameController.text, double.parse(_priceController.text), _categoryIdController);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Utworzono nowy artykuł')));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetail(
                                    article: Provider.of<ShopStore>(context, listen: false).getArticleById(id))));
                      },
                      child: Text('Dodaj'.toUpperCase(),
                          style: const TextStyle(fontSize: 18, letterSpacing: 1)),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero)),
                    ))
              ],
            ),
          )),
    );
  }
}
