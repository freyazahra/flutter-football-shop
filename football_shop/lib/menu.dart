import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final List<ProductHomepage> productButtons = const [
    ProductHomepage(
      "All Products",
      Icons.list_alt,
      Colors.blue,
      "Kamu telah menekan tombol All Products",
    ),
    ProductHomepage(
      "My Products",
      Icons.person,
      Colors.green,
      "Kamu telah menekan tombol My Products",
    ),
    ProductHomepage(
      "Create Product",
      Icons.add_box,
      Colors.red,
      "Kamu telah menekan tombol Create Product",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Football Shop',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            shrinkWrap: true,
            children: productButtons.map((ProductHomepage item) {
              return ProductButton(item);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

// Data class tombol produk
class ProductHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final String snackbarMessage;

  const ProductHomepage(this.name, this.icon, this.color, this.snackbarMessage);
}

// Widget tombol produk
class ProductButton extends StatelessWidget {
  final ProductHomepage item;
  const ProductButton(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(item.snackbarMessage)));
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30),
                const SizedBox(height: 5),
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
