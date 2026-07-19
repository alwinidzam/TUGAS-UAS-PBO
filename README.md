# UAS OOP Dart - Sistem Akademik

## Identitas

- Nama: Muhammad Alwi Nidzam
- NIM : 251240001589

## Tema Aplikasi

Aplikasi manajemen mata kuliah berbasis terminal atau CLI dengan tema Sistem Akademik.

## Fitur Program

- Tambah data mata kuliah wajib dan mata kuliah pilihan.
- Lihat semua data mata kuliah.
- Cari data berdasarkan kode, nama, atau jenis.
- Hitung total mata kuliah, total SKS, rata-rata SKS, daftar kode, dan ringkasan jenis.
- Simulasi simpan data menggunakan `async` dan `await`.

## Konsep OOP yang Digunakan

- Class dan object: `MataKuliah`, `MataKuliahWajib`, `MataKuliahPilihan`, dan `Manager`.
- Encapsulation: field private, getter, setter, dan validasi data.
- Inheritance: `MataKuliahWajib` dan `MataKuliahPilihan` mewarisi `MataKuliah`.
- Polymorphism: getter `keterangan` dioverride pada class turunan.
- Collection: `List`, `Set`, dan `Map`.
- Higher-order function: `where()`, `fold()`, `map()`, dan `forEach()`.
- Exception: `DataTidakValidException`.
- Async/Await: method `simpanData()`.

## Struktur Folder

```text
UAS/
|-- bin/
|   |-- main.dart
|   `-- uas.dart
|-- lib/
|   |-- controllers/
|   |   `-- manager.dart
|   |-- exceptions/
|   |   `-- data_tidak_valid_exception.dart
|   `-- models/
|       |-- mata_kuliah.dart
|       |-- mata_kuliah_pilihan.dart
|       `-- mata_kuliah_wajib.dart
`-- README.md
```

## Cara Menjalankan Program

Masuk ke folder `UAS`, lalu jalankan:

```bash
dart bin/main.dart
```

Alternatif:

```bash
dart bin/uas.dart
```
