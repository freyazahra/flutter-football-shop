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

== TUGAS 9 ==

## 1. Mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON?

**Inti:** Model Dart menyediakan struktur tipe yang jelas, validasi awal, dan kontrak data yang kuat antara backend (Django) dan frontend (Flutter).

**Alasan rinci:**

* **Typings & null-safety:** Dart (terutama bila menggunakan null-safety) membutuhkan penanganan tipe yang eksplisit. Model memastikan atribut yang diharapkan ada dan memiliki tipe yang sesuai (`String`, `int`, `DateTime`, dll.).
* **Deserialisasi terkontrol:** Dengan model kita bisa membuat `fromJson` dan `toJson` yang menangani konversi, parsing tanggal, nilai default, serta transformasi (mis. `price` dari `String` ke `double`).
* **Validasi awal:** Model dapat memeriksa nilai tidak wajar (mis. stok negatif) sehingga bug ditangkap lebih awal.
* **Auto-completion & maintainability:** IDE seperti VSCode/Android Studio memberi autocompletion berdasarkan model sehingga memudahkan pengembangan dan refaktor.
* **Encapsulation & metode bantu:** Model bisa menampung metode bantu (mis. `formattedPrice()` atau `isAvailable()`) sehingga logika terkait data tidak tersebar di UI.

**Kesimpulan:** Model membuat data lebih aman, eksplisit, dan mudah dirawat.

---

## 2. Konsekuensi jika langsung memetakan `Map<String, dynamic>` tanpa model

**Kerugian utama:**

* **Kehilangan jaminan tipe:** Anda akan sering melakukan cast manual (`json['price'] as double?`) yang rawan runtime error.
* **Null-safety terabaikan:** Lebih sulit memastikan atribut mana yang memang boleh `null` dan mana yang tidak.
* **Sulit dipelihara & fragile:** Saat struktur JSON berubah, kesalahan tersebar di banyak file UI yang mengakses `Map`.
* **Kurang self-documenting:** Kode jadi kurang jelas tentang bentuk data yang diharapkan.
* **Debugging lebih sulit:** Kesalahan tipe baru terlihat saat runtime, bukan saat compile.

**Kapan `Map<String, dynamic>` bisa dipakai:**

* Prototyping cepat, eksperimen, atau endpoint yang benar-benar dinamis dan tidak terstruktur.
* Namun untuk aplikasi production atau kode tim, model tetap direkomendasikan.

---

## 3. Fungsi package `http` dan `CookieRequest`. Perbedaan peran `http` vs `CookieRequest`

**`http` package:**

* Library dasar untuk melakukan request HTTP (GET, POST, PUT, DELETE) — cocok untuk permintaan stateless ke API.
* Mengembalikan `http.Response` berisi body, status code, header.
* Tidak menahan atau mengelola cookie/session secara otomatis (kecuali Anda implementasikan sendiri).

**`CookieRequest` (mis. dari package `cookie_request` atau implementasi serupa):**

* Built on top of `http` tetapi menambahkan manajemen cookie otomatis.
* Menyimpan cookie yang diterima dari server (Set-Cookie) dan menyertakannya pada request berikutnya.
* Mempermudah autentikasi berbasis session (mis. Django sessionid) serta mekanisme CSRF (membaca token CSRF dari cookie/ganti header).

**Perbedaan subtantif:**

* `http` = *low-level stateless HTTP client*.
* `CookieRequest` = *stateful client* yang menangani cookie/session, cocok ketika server memakai session-based auth (Django default) atau ketika perlu otomatis menyertakan CSRF token.

---

## 4. Mengapa instance `CookieRequest` perlu dibagikan ke semua komponen di aplikasi Flutter?

**Alasan:**

* **Satu sumber kebenaran untuk session:** Cookie (mis. `sessionid`) dan header CSRF harus sama di seluruh bagian aplikasi. Jika tiap komponen membuat instance-nya sendiri, mereka tidak berbagi cookie jadi autentikasi akan gagal/terputus.
* **Konsistensi autentikasi:** Setelah login, cookie session yang didapat perlu dipakai oleh semua request (produk, cart, checkout). Shared instance memastikan ini.
* **Kemudahan pengelolaan state:** Anda bisa menempatkan `CookieRequest` di Provider, Riverpod, GetIt, atau InheritedWidget sehingga siap pakai di seluruh widget tree.
* **Pengaturan ulang (logout) lebih mudah:** Hanya perlu clear cookie pada satu instance untuk mengeluarkan semua komponen.

**Implementasi umum:** Inisialisasi `CookieRequest` di root (mis. `main()`), lalu inject ke `Provider`/`ChangeNotifier`/`Riverpod`—akses lewat `context.read(...)` atau provider hook.

---

## 5. Konfigurasi konektivitas agar Flutter dapat berkomunikasi dengan Django

**Langkah penting & alasannya:**

1. **Tambahkan `10.0.2.2` di `ALLOWED_HOSTS` Django**

   * Android emulator `10.0.2.2` merefer ke host machine (localhost pada komputer dev). Jika tidak diizinkan, Django akan menolak request dengan `DisallowedHost`.
2. **Aktifkan CORS (Cross-Origin Resource Sharing)**

   * Ketika Flutter Web atau aplikasi mobile berbasis WebView berkomunikasi ke backend, browser (atau mekanisme serupa) menegakkan CORS. Untuk API, install `django-cors-headers` dan set `CORS_ALLOW_ALL_ORIGINS` atau whitelist origin dev.
3. **Pengaturan SameSite / cookie (CSRF & session)**

   * Untuk session-based auth dan CSRF, set `SESSION_COOKIE_SAMESITE` dan `CSRF_COOKIE_SAMESITE` sesuai kebutuhan (mis. `None` bila cross-site dan bersama dengan `SESSION_COOKIE_SECURE = True` pada HTTPS). Tanpa konfigurasi benar, cookie mungkin tidak dikirim sehingga login/session gagal.
4. **Izin Internet di Android (AndroidManifest.xml)**

   * Tambahkan `<uses-permission android:name="android.permission.INTERNET" />`. Tanpa ini, aplikasi Android tidak bisa melakukan request jaringan.

**Apa yang terjadi jika salah konfigurasi:**

* `DisallowedHost` atau 400 jika host tidak terdaftar.
* Permintaan gagal karena cookie/session tidak disertakan -> login tampak sukses di server tapi Flutter tidak mendapatkan session.
* CORS error yang mencegah response diakses (terutama di Flutter Web).
* Tanpa izin Internet, semua request jaringan di Android akan gagal (no route / exception).

---

## 6. Mekanisme pengiriman data — dari input hingga tampil di Flutter

**Alur umum:**

1. **User input di UI:** Widget form mengumpulkan data (mis. `TextFormField`).
2. **Validasi lokal:** Validasi sisi client (required, format email, panjang password).
3. **Bungkus ke model & serialize:** Buat instance model Dart dan panggil `toJson()` untuk menghasilkan `Map<String, dynamic>` atau JSON string.
4. **Kirim request HTTP (menggunakan `CookieRequest`/`http`):** POST/PUT ke endpoint Django dengan body JSON dan header yang sesuai (Content-Type, X-CSRFToken bila perlu).
5. **Server memproses:** Django menerima data, memvalidasi (serializer/form), menyimpan ke DB, dan mengembalikan response (200/201 + JSON).
6. **Client menerima response:** Deserialize ke model melalui `fromJson()`.
7. **Update UI/state management:** Simpan hasil di provider/riverpod/bloc dan beri tahu widget untuk rebuild sehingga data tampil.

**Catatan:** Selalu tangani error (400, 401, 500) dan tampilkan pesan informatif ke user.

---

## 7. Mekanisme autentikasi: login, register, logout (end-to-end)

**Register:**

1. User mengisi form registrasi di Flutter.
2. Flutter memvalidasi input lalu mengirim POST `/api/register/` dengan body JSON.
3. Django menerima -> validasi server-side -> buat user -> bisa langsung login (kembalikan session cookie) atau minta verifikasi email.
4. Jika server mengembalikan cookie session, `CookieRequest` menyimpan cookie tersebut untuk request selanjutnya.

**Login:**

1. User kirim email/password lewat Flutter ke endpoint login (mis. POST `/api/login/`).
2. Django meng-autentikasi, lalu mengembalikan `sessionid` (Set-Cookie) dan biasanya CSRF token.
3. `CookieRequest` otomatis menyimpan cookie; semua request berikutnya menyertakan cookie untuk otorisasi session.
4. Flutter menandai user sebagai `authenticated` (update provider), menampilkan menu/menu khusus user.

**Logout:**

1. Flutter panggil endpoint logout (mis. POST `/api/logout/`) atau cukup clear cookie di client.
2. Django menghancurkan session di server; client `CookieRequest` juga harus menghapus cookie.
3. Flutter kembali ke state `unauthenticated` dan tampilkan layar login/register.

**Catatan CSRF:** Untuk request state-changing (POST/PUT/DELETE), Django memerlukan CSRF token. Umumnya token diberikan lewat cookie `csrftoken` dan perlu disertakan di header `X-CSRFToken`. `CookieRequest`/middleware yang baik akan otomatis membaca cookie dan menambahkan header ini.

---

## 8. Implementasi step-by-step (cara saya melakukannya, bukan sekadar ikut tutorial)

**Langkah praktis yang saya rekomendasikan:**

1. **Desain kontrak API dulu (schema JSON)** — Tentukan bentuk request/response (contoh JSON) untuk register, login, produk, cart.
2. **Buat model Dart dari schema** — Tuliskan kelas model lengkap dengan `fromJson`/`toJson` dan default values serta validasi ringan.
3. **Integrasi CookieRequest global:** Inisialisasi di `main()` dan inject ke Provider/Riverpod agar dapat diakses dari semua widget.
4. **Implementasi register/login di backend:** Pastikan endpoint mengembalikan cookie `sessionid` dan `csrftoken` serta response JSON yang jelas.
5. **CORS & ALLOWED_HOSTS:** Sesuaikan `settings.py` (daftarkan `10.0.2.2` untuk emulator, aktifkan `corsheaders`).
6. **Uji manual endpoint dengan HTTP client (Postman/curl)** untuk memastikan cookie diset dan header CSRF tersedia.
7. **Buat UI form di Flutter:** Gunakan `Form`+`TextFormField` dengan validator; setelah submit panggil service auth.
8. **Lakukan end-to-end test di emulator:** Tes register -> login -> akses resource yang protected.
9. **Tangani edge cases:** expirasi cookie, refresh token (jika pakai token), error handling 400/401.
10. **Refactor ke production:** Kode rapi, tampilan loading, notifikasi error, dan unit/integration tests untuk model dan service.

**Tambahan best-practices:**

* Simpan base URL dan konfigurasi (dev/prod) di satu tempat.
* Jangan log credential ke console.
* Pastikan komunikasi sensitif (password, token) melalui HTTPS di production.
