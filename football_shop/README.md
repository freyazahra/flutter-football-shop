# flutter-football-shop
== TUGAS 7 ==
1. Apa itu widget tree dan hubungan parent-child antar widget?
- Widget Tree adalah struktur hierarki dari semua widget dalam aplikasi Flutter. Semua UI di Flutter dibangun dari widget yang disusun secara bertingkat, mirip pohon (tree).
- Setiap widget bisa memiliki child (anak), atau beberapa children jika widget tersebut mendukung banyak anak.
- Parent-child relationship:
Parent widget: widget yang membungkus atau menampung widget lain.
Child widget: widget yang berada di dalam parent, menjadi bagian dari UI parent.

2. Semua widget yang digunakan di proyek ini dan fungsinya
| `MaterialApp`    | Root widget aplikasi Flutter, menyediakan tema, routing, dan material design.      |
| `Scaffold`       | Struktur dasar halaman, menyediakan `AppBar`, `body`, `FloatingActionButton`, dll. |
| `AppBar`         | Bar bagian atas halaman yang biasanya menampilkan judul atau aksi.                 |
| `Padding`        | Memberi jarak di sekitar widget child.                                             |
| `Center`         | Menempatkan widget child di tengah.                                                |
| `GridView.count` | Menampilkan banyak widget dalam grid dengan jumlah kolom tertentu.                 |
| `Material`       | Widget yang menyediakan visual material (color, elevation, border radius).         |
| `InkWell`        | Widget interaktif, menangkap tap/click dan memberikan efek ripple.                 |
| `Container`      | Kotak untuk menampung widget lain, bisa diberi padding, margin, warna, dsb.        |
| `Column`         | Menyusun widget secara vertikal.                                                   |
| `Icon`           | Menampilkan ikon.                                                                  |
| `Text`           | Menampilkan teks.                                                                  |
| `SnackBar`       | Menampilkan pesan sementara di bagian bawah layar.                                 |


3. Fungsi MaterialApp dan kenapa sering digunakan sebagai root
Fungsi:
MaterialApp adalah root widget yang menyediakan:
- Material Design style.
- Theme global untuk warna dan font.
- Routing dan navigasi antar halaman.
- Localization dan konfigurasi dasar lainnya.
Alasan sering digunakan:
Flutter apps biasanya menggunakan material design, jadi MaterialApp mempermudah setup tema dan navigasi.
Semua widget material lain (Scaffold, AppBar, SnackBar) membutuhkan MaterialApp sebagai ancestor agar tampil dengan style material.

4. Perbedaan StatelessWidget dan StatefulWidget
StatelessWidget	
- Tidak memiliki state internal. UI hanya tergantung input (parameter).	
- Digunakan untuk widget yang tidak berubah, misal tombol statis, teks, ikon.	

StatefulWidget
- Memiliki state internal yang bisa berubah, dan UI akan update ketika state berubah
- Digunakan untuk widget yang dinamis, misal counter, form input, atau tombol yang merespons aksi.

Kapan dipilih:
- Pilih StatelessWidget jika UI statis, cukup sekali build.
- Pilih StatefulWidget jika UI dinamis atau perlu merespon interaksi pengguna.

5. Apa itu BuildContext dan penggunaannya
BuildContext adalah referensi ke lokasi widget dalam widget tree.
Memberi akses ke:
- Ancestor widget (Theme.of(context), Scaffold.of(context)).
- Navigasi dan routing (Navigator.of(context)).
Digunakan di metode build() untuk mengakses properti parent atau theme, misal:
backgroundColor: Theme.of(context).colorScheme.primary
Penting karena memungkinkan widget untuk berinteraksi dengan parent dan widget lain dalam tree.

6. Konsep hot reload dan hot restart
Hot Reload	
- Memuat ulang kode yang diubah tanpa kehilangan state aplikasi.	
- Cepat, digunakan saat ubah UI atau logika kecil.	
- Cocok untuk development dan desain UI interaktif.

Hot Restart
- Memulai ulang seluruh aplikasi dari awal, state hilang.
- Digunakan saat ada perubahan di root atau inisialisasi global, misal main() atau dependency baru.
- Cocok ketika perubahan memerlukan reload penuh agar bekerja.

== TUGAS 8 ==
1. Perbedaan Navigator.push() dan Navigator.pushReplacement()
Perbedaan utamanya terletak pada cara Flutter mengelola "tumpukan" (stack) halaman:

- Navigator.push() ibarat menumpuk piring baru di atas tumpukan piring yang sudah ada. Halaman lama (misalnya HomePage) tidak hilang, ia hanya tertutup oleh halaman baru (misalnya ProductFormPage). Pengguna bisa menekan tombol "Back" (panah kembali di AppBar) untuk kembali ke halaman sebelumnya.

Kasus di Football Shop: Saya menggunakan Navigator.push() (melalui Navigator.pushNamed) pada ShopCard "Add Product" di halaman utama. Ini adalah pilihan logis, karena pengguna mungkin ingin kembali (Back) ke halaman utama jika mereka batal atau tidak jadi mengisi formulir.

- Navigator.pushReplacement() ibarat mengganti piring di paling atas dengan piring baru. Halaman yang sedang aktif (misalnya ProductFormPage) akan dibuang dari tumpukan dan digantikan oleh halaman baru (misalnya HomePage). Pengguna tidak bisa menekan tombol "Back" untuk kembali ke halaman yang sudah diganti.

Kasus di Football Shop: Saya menggunakan Navigator.pushReplacement() (melalui Navigator.pushReplacementNamed) di dua tempat:

Di LeftDrawer: Saat berpindah dari Home ke Add Product (atau sebaliknya) melalui drawer. Ini penting agar tumpukan halaman tidak menumpuk tanpa batas setiap kali pengguna berpindah menu.

Setelah Menyimpan Form: Di dalam AlertDialog setelah menekan "OK". Ini menggantikan halaman form dengan halaman utama, karena proses "tambah produk" sudah selesai dan pengguna tidak perlu kembali lagi ke form yang sudah kosong.

2. Pemanfaatan Scaffold, AppBar, dan Drawer
Ketiga widget ini adalah fondasi untuk membangun struktur halaman yang konsisten di aplikasi saya:

- Scaffold: Saya gunakan sebagai "cetakan" atau kerangka dasar untuk setiap halaman baru (main_page.dart dan product_form_page.dart). Scaffold menyediakan slot-slot standar seperti appBar, body, dan drawer. Dengan menggunakan Scaffold di setiap halaman, saya memastikan semua halaman punya struktur yang sama.

- AppBar: Saya atur AppBar agar selalu menampilkan judul 'Football Shop' (atau judul halaman terkait) dengan background Colors.indigo dan teks Colors.white. Ini langsung memberikan identitas visual yang seragam di bagian atas setiap halaman.

- Drawer: Ini adalah kunci konsistensi navigasi. Saya membuat satu widget khusus, LeftDrawer (lib/widgets/left_drawer.dart), yang berisi semua menu navigasi (Home dan Add Product). Kemudian, di setiap Scaffold (di main_page.dart dan product_form_page.dart), saya cukup memanggil drawer: const LeftDrawer(). Hasilnya, drawer di semua halaman pasti sama, berfungsi sama, dan punya tampilan yang konsisten.

3. Kelebihan Padding, SingleChildScrollView, dan ListView pada Form
Widget ini sangat penting untuk membuat formulir yang fungsional dan rapi:

- Padding: Kelebihan utamanya adalah estetika dan kerapian. Tanpa Padding, field input seperti TextFormField akan menempel rapat ke tepi layar dan menempel satu sama lain.

Contoh: Di product_form_page.dart, saya membungkus setiap TextFormField dengan Padding(padding: const EdgeInsets.all(8.0), ...). Ini memberikan "ruang napas" yang jelas antar elemen form, sehingga antarmuka terlihat bersih dan mudah digunakan.

- SingleChildScrollView: Kelebihan utamanya adalah fungsionalitas dan User Experience (UX). Ini adalah widget krusial untuk formulir.

Contoh: Saya membungkus seluruh Form (yang berisi Column dari semua field) dengan SingleChildScrollView. Ini untuk mengatasi masalah umum di layar smartphone: saat keyboard virtual muncul, field yang ada di bagian bawah akan tertutup. Dengan SingleChildScrollView, pengguna tetap bisa scroll ke bawah untuk melihat dan mengisi field "Description" atau "Thumbnail" meskipun keyboard sedang aktif.

- ListView: (Meskipun di form ini saya menggunakan Column di dalam SingleChildScrollView yang lebih cocok untuk form statis), ListView punya kelebihan serupa dengan SingleChildScrollView (otomatis bisa scroll). Kelebihan utamanya adalah efisiensi memori jika form-nya sangat dinamis atau memiliki list widget yang sangat banyak, karena ListView (terutama ListView.builder) hanya me-render elemen yang terlihat di layar.

4. Penyesuaian Warna Tema untuk Identitas Brand
Untuk menciptakan identitas visual "Football Shop" yang konsisten, saya menetapkan warna tema utama di main.dart.

Di dalam widget MaterialApp, saya mengatur properti theme sebagai berikut:

Dart

      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
Dengan menyetel primarySwatch: Colors.indigo, Flutter secara otomatis menggunakan Colors.indigo (warna biru tua yang profesional) sebagai warna utama aplikasi. Inilah yang secara otomatis memberi warna pada AppBar di semua halaman.

Untuk lebih memperkuat identitas brand, saya juga mengatur properti AppBar secara spesifik di setiap halaman (meskipun sebagian sudah di-cover oleh tema) untuk memastikan konsistensi, misalnya:

Dart

      appBar: AppBar(
        title: const Text('Football Shop', style: TextStyle(color: Colors.white, ...)),
        backgroundColor: Colors.indigo, // Mempertegas warna brand
        foregroundColor: Colors.white, // Memastikan icon (seperti icon drawer) berwarna putih
      ),