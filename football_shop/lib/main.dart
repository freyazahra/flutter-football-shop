import 'package:flutter/material.dart';
import 'package:football_shop/screens/main_page.dart';
import 'package:football_shop/screens/product_form_page.dart';
import 'package:football_shop/screens/register.dart';
import 'package:football_shop/screens/item_list_page.dart';
import 'package:football_shop/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) {
        CookieRequest request = CookieRequest();
        return request;
      },
      child: MaterialApp(
        title: 'Football Shop',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // Mulai dari halaman login agar user terautentikasi sebelum masuk ke fitur utama
        initialRoute: '/login', 
        routes: {
          '/': (context) => MyHomePage(), 
          '/add_product': (context) => const ProductFormPage(),
          '/login': (context) => const LoginPage(), // Gunakan const jika LoginPage adalah StatelessWidget/StatefulWidget tanpa parameter wajib
          '/register': (context) => const RegisterPage(), // Gunakan const jika RegisterPage adalah StatelessWidget/StatefulWidget tanpa parameter wajib
          '/items': (context) => const ItemListPage(), // Gunakan const jika ItemListPage adalah StatelessWidget/StatefulWidget tanpa parameter wajib
          
          // CATATAN PENTING: ItemDetailPage membutuhkan objek Item.
          // Routing bernama TIDAK BISA menyediakan objek Item secara langsung,
          // sehingga kita tidak bisa menggunakan rute '/item_detail'.
          // Gunakan push biasa dari ItemListPage (sudah kamu lakukan di file tersebut).
          // Jika kamu tetap ingin mendefinisikan rute ini, berikan widget placeholder atau 
          // pastikan ItemDetailPage tidak memiliki parameter wajib.
          
          // Karena ItemDetailPage butuh data: Jangan panggil ini via route bernama.
          // '/item_detail': (context) => ItemDetailPage(), // DIHAPUS ATAU DIKOMENTARI
        },
      ),
    );
  }
}