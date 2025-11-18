import 'package:flutter/material.dart';
import 'package:football_shop/models/item.dart';
import 'package:football_shop/screens/item_detail_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/config.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  // State untuk menentukan filter: 'all' atau 'mine'
  String _currentFilter = 'all'; 

  Future<List<Item>> fetchItems(CookieRequest request) async {
    String filterQuery = '';
    
    // 1. Tambahkan parameter ?mine=1 jika filter adalah 'mine'
    if (_currentFilter == 'mine') {
      filterQuery = '?mine=1';
    }
    
    // 2. Gabungkan backendBase dengan query filter
    final response = await request.get('$backendBase/api/products/$filterQuery');
    
    var data = response;
    
    List<Item> listItems = [];
    if (data is List) { // Pastikan data adalah List
      for (var d in data) {
        if (d != null) {
          listItems.add(Item.fromJson(d));
        }
      }
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // Dropdown untuk Filter Produk
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              value: _currentFilter,
              icon: const Icon(Icons.filter_list, color: Colors.white),
              dropdownColor: Colors.indigo,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _currentFilter = newValue; // Mengubah state dan memicu FutureBuilder refresh
                  });
                }
              },
              items: const [
                DropdownMenuItem(
                  value: 'all',
                  child: Text('All Products', style: TextStyle(color: Colors.white)),
                ),
                DropdownMenuItem(
                  value: 'mine',
                  child: Text('My Products', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        // Panggil fetchItems lagi setiap kali _currentFilter berubah
        future: fetchItems(request), 
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentFilter == 'mine' 
                        ? "You haven't added any products or you are not logged in."
                        : "No products available.",
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    if (_currentFilter == 'mine' && !request.loggedIn)
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        child: const Text("Log in to see your products."),
                      )
                  ],
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, index) {
                final Item item = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailPage(item: item),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail handling
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: item.thumbnail.isNotEmpty
                                ? Image.network(
                                    item.thumbnail,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (ctx, err, st) => 
                                      Container(width: 80, height: 80, color: Colors.grey[300], child: const Icon(Icons.broken_image)),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.indigo[100],
                                    child: const Icon(Icons.sports_soccer, size: 40, color: Colors.indigo),
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Rp ${item.price}",
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.green, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Owner: ${item.owner}",
                                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          if (item.isFeatured)
                             const Icon(Icons.star, color: Colors.amber),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}