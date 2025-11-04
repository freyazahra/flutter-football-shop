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