import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/screens/item_list_page.dart';
import 'package:football_shop/screens/login.dart';
import 'package:football_shop/screens/product_form_page.dart';
import 'package:football_shop/config.dart';

class ProductItem {
  final String name;
  final IconData icon;
  final Color color;
  ProductItem(this.name, this.icon, this.color);
}

class ShopCard extends StatelessWidget {
  final ProductItem item;
  const ShopCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () async {
          if (item.name == "Add Product") {
             Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProductFormPage()));
          } else if (item.name == "View Products") {
             Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ItemListPage()));
          } else if (item.name == "Logout") {
            final response = await request.logout("$backendBase/auth/logout/");
            String message = response["message"];
            if (context.mounted) {
              if (response['status']) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                ));
              }
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}