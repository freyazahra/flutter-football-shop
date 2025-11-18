import 'package:flutter/material.dart';
import 'package:football_shop/models/item.dart';

class ItemDetailPage extends StatelessWidget {
  final Item item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Product"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            SizedBox(
              width: double.infinity,
              height: 300,
              child: item.thumbnail.isNotEmpty
                  ? Image.network(
                      item.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => 
                          Container(color: Colors.grey, child: const Center(child: Icon(Icons.broken_image, size: 50))),
                    )
                  : Container(color: Colors.indigo[100], child: const Center(child: Icon(Icons.sports_soccer, size: 100, color: Colors.indigo))),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (item.isFeatured)
                         const Chip(label: Text("Featured"), backgroundColor: Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rp ${item.price}",
                    style: const TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.category, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(item.category, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(width: 16),
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(item.owner, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                  const Divider(height: 30),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Back to List", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}