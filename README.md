# 🎬 Flutter Movie Ticket Booking App

Aplikasi mobile berbasis **Flutter** untuk menampilkan daftar film, mencari film, melihat detail film, dan melakukan simulasi pemesanan kursi bioskop menggunakan **Public API**.

---

## 📌 Deskripsi Project

Project ini dibuat untuk memenuhi tugas **Ujian Tengah Semester (UTS)** mata kuliah **Lab Pengembangan Aplikasi Mobile**.

Aplikasi menggunakan data real-time dari **The Movie Database (TMDB) API** dan menerapkan konsep:

* Konsumsi REST API
* State Management
* Asynchronous Programming
* Reusable Widget
* Responsive UI
* Error Handling

---

## ✨ Fitur Utama

### 🎥 Dashboard Film

* Menampilkan daftar film terbaru / upcoming movie
* Tampilan modern dan responsif
* Data diambil langsung dari API

### 🔍 Pencarian Film

* Mencari judul film secara real-time
* Menggunakan `async/await`
* UI tetap responsif saat proses pencarian

### 🎟 Detail Film & Booking

* Menampilkan informasi film
* Simulasi pemilihan kursi bioskop
* Simulasi pembelian tiket

### 📚 Media Library

* Halaman koleksi film
* Tampilan menarik dan modern

### ⚙️ Menu More

* Informasi aplikasi
* Profil developer
* Versi aplikasi

---

## 🛠 Teknologi yang Digunakan

| Teknologi    | Fungsi                    |
| ------------ | ------------------------- |
| Flutter      | Framework aplikasi mobile |
| Dart         | Bahasa pemrograman        |
| Provider     | State Management          |
| HTTP         | Request API               |
| TMDB API     | Sumber data film          |
| Google Fonts | Typography                |
| Shimmer      | Loading animation         |

---

## 📂 Struktur Folder Project

```text id="l8h94s"
lib/
│── apiz/                 # Service API
│── controllers/          # Logic & State Management
│── data/                 # Model data JSON
│── modules/              # Halaman aplikasi
│── widgets/              # Reusable widget
│── utils/                # Theme, warna, constant
│── main.dart             # Entry point aplikasi
```

---

## 🧠 Alasan Menggunakan Provider

Project ini menggunakan **Provider** karena:

* Ringan dan mudah dipahami
* Cocok untuk project skala menengah
* Memisahkan UI dan logic dengan baik
* Mudah maintenance
* Reaktif menggunakan `notifyListeners()`

---

## 🔄 Implementasi Asynchronous

Aplikasi menggunakan:

```dart id="jfw8cz"
async / await
Future
HTTP Request
```

Tujuannya agar tampilan tetap lancar dan tidak freeze saat mengambil data dari internet.

---

## ♻️ Reusable Widget

Untuk efisiensi code dan konsistensi UI, project ini menggunakan widget yang dapat dipakai ulang:

* `ErrorView`
* `Loading`
* `CustomSearchField`
* `WatchImageViewItem`
* `SearchItemView`
* `ShimmerDashboardLoading`

---

## ⚠️ Error Handling

Aplikasi menangani kondisi:

* Tidak ada koneksi internet
* Gagal mengambil data API
* Error sistem

User akan melihat pesan yang ramah dan tombol retry.

---

## 🌐 Sumber API

Menggunakan:

**The Movie Database API (TMDB)**
https://www.themoviedb.org/

---

## 🚀 Cara Menjalankan Project

flutter pub get
flutter run

Untuk Web:

flutter run -d chrome

---

## 👩‍💻 Developer

**Nabila Arifa Umayi**
Mahasiswa Sistem Informasi
Project UTS Mobile Development

---

## 📌 Versi

`v1.0.0`

---

## 📄 Catatan

Project ini dibuat untuk kebutuhan akademik dan pembelajaran.
