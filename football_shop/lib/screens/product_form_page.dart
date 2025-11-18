import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'package:football_shop/models/item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/config.dart';
import 'package:football_shop/screens/main_page.dart';

class ProductFormPage extends StatefulWidget {
  final Item? item;
  const ProductFormPage({super.key, this.item});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "boots";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'boots', 'jerseys', 'balls', 'accessories', 'training', 'equipment',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _name = widget.item!.name;
      _price = widget.item!.price;
      _description = widget.item!.description;
      _category = widget.item!.category;
      _thumbnail = widget.item!.thumbnail;
      _isFeatured = widget.item!.isFeatured;
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Product')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  hintText: "Product Name",
                  labelText: "Product Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onChanged: (String? value) { setState(() { _name = value!; }); },
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Name cannot be empty!";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _price == 0 ? "" : _price.toString(),
                decoration: InputDecoration(
                  hintText: "Price",
                  labelText: "Price",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                keyboardType: TextInputType.number,
                onChanged: (String? value) { 
                  setState(() { _price = int.tryParse(value!) ?? 0; }); 
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Price cannot be empty!";
                  if (int.tryParse(value) == null) return "Price must be a number!";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(
                  hintText: "Description",
                  labelText: "Description",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                maxLines: 3,
                onChanged: (String? value) { setState(() { _description = value!; }); },
                validator: (String? value) {
                  if (value == null || value.isEmpty) return "Description cannot be empty!";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _categories.contains(_category) ? _category : _categories.first,
                decoration: InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category[0].toUpperCase() + category.substring(1)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() { _category = newValue!; });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _thumbnail,
                decoration: InputDecoration(
                  hintText: "Thumbnail URL",
                  labelText: "Thumbnail URL",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                onChanged: (String? value) { setState(() { _thumbnail = value!; }); },
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text("Mark as Featured"),
                value: _isFeatured,
                onChanged: (bool value) { setState(() { _isFeatured = value; }); },
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Cek apakah ada masalah dengan konversi harga
                      if (_price <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Price must be greater than 0.")),
                          );
                          return;
                      }

                      final response = await request.postJson(
                        "$backendBase/create-flutter/",
                        jsonEncode(<String, dynamic>{
                          'name': _name,
                          'price': _price,
                          'description': _description,
                          'category': _category,
                          'thumbnail': _thumbnail,
                          'is_featured': _isFeatured,
                        }),
                      );

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Product saved successfully!")),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MyHomePage()),
                          );
                        } else {
                          // Tampilkan pesan error spesifik dari Django
                          String errorMessage = response['message']?.toString() ?? 'Unknown error occurred.';

                          // Jika status 401/Unauthorized dari Django, kita tampilkan pesan yang spesifik
                          if (errorMessage.contains('Authentication required')) {
                                errorMessage = "Saving failed: You must be logged in to add a product.";
                          }
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error saving product: $errorMessage")),
                          );
                        }
                      }
                    }
                  },
                  child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}