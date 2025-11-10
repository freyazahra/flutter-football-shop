import 'package:flutter/material.dart';

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
    return Material(
      color: item.color,
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("You tapped on ${item.name}!")));

          if (item.name == "Add Product") {
            Navigator.pushNamed(context, '/add_product');
          } else if (item.name == "View Products") {
          } else if (item.name == "Logout") {
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
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