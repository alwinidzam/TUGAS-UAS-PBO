import 'dart:io';

import '../lib/controllers/manager.dart';
import '../lib/exceptions/data_tidak_valid_exception.dart';
import '../lib/models/mata_kuliah.dart';
import '../lib/models/mata_kuliah_pilihan.dart';
import '../lib/models/mata_kuliah_wajib.dart';

const garis = '============================================================================';
const garisPendek = '----------------------------------------------------------------------------';

Future<void> main() async {
  Manager manager = Manager();
  isiDataAwal(manager);

  bool jalan = true;

  while (jalan) {
    tampilkanMenu();
    String pilihan = bacaInput('Pilih menu');

    try {
      switch (pilihan) {
        case '1':
          tambahData(manager);
          break;
        case '2':
          tampilkanDaftar('DATA MATA KULIAH', manager.semuaMataKuliah);
          break;
        case '3':
          cariData(manager);
          break;
        case '4':
          tampilkanTotal(manager);
          break;
        case '5':
          tampilkanPesan('PROSES', 'Menyimpan data...');
          await manager.simpanData();
          tampilkanPesan('SUKSES', 'Data berhasil disimpan.');
          break;
        case '6':
          jalan = false;
          tampilkanPesan('SELESAI', 'Terima kasih. Program selesai.');
          break;
        default:
          throw DataTidakValidException('Menu tidak tersedia.');
      }
    } on DataTidakValidException catch (e) {
      tampilkanPesan('ERROR', e.pesan);
    } catch (e) {
      tampilkanPesan('ERROR', 'Terjadi kesalahan: $e');
    }

    if (jalan) {
      print('');
    }
  }
}

void isiDataAwal(Manager manager) {
  manager.tambah(MataKuliahWajib(
    kode: 'MK001',
    nama: 'Pemrograman Berorientasi Objek',
    sks: 3,
    semester: 4,
  ));

  manager.tambah(MataKuliahPilihan(
    kode: 'MK002',
    nama: 'Kecerdasan Buatan',
    sks: 3,
    minat: 'Teknologi Cerdas',
  ));
}

void tampilkanMenu() {
  tampilkanJudul('SISTEM AKADEMIK');
  print('1. Tambah data');
  print('2. Lihat semua data');
  print('3. Cari data');
  print('4. Hitung total');
  print('5. Simpan data');
  print('6. Keluar');
  print(garisPendek);
}

void tambahData(Manager manager) {
  tampilkanJudul('TAMBAH MATA KULIAH');
  print('1. Mata kuliah wajib');
  print('2. Mata kuliah pilihan');
  print(garisPendek);

  String jenis = bacaInput('Pilih jenis');
  String kode = bacaInput('Kode');
  String nama = bacaInput('Nama');
  int sks = bacaAngka('SKS');

  if (jenis == '1') {
    int semester = bacaAngka('Semester');

    manager.tambah(MataKuliahWajib(
      kode: kode,
      nama: nama,
      sks: sks,
      semester: semester,
    ));
  } else if (jenis == '2') {
    String minat = bacaInput('Bidang minat');

    manager.tambah(MataKuliahPilihan(
      kode: kode,
      nama: nama,
      sks: sks,
      minat: minat,
    ));
  } else {
    throw DataTidakValidException('Jenis mata kuliah tidak tersedia.');
  }

  tampilkanPesan('SUKSES', 'Data berhasil ditambahkan.');
}

void cariData(Manager manager) {
  String keyword = bacaInput('Masukkan kata kunci');
  List<MataKuliah> hasil = manager.cari(keyword);

  tampilkanDaftar('HASIL PENCARIAN', hasil);
}

void tampilkanTotal(Manager manager) {
  Map<String, int> ringkasan = manager.hitungJumlahPerJenis();

  tampilkanJudul('RINGKASAN DATA');
  print('${'Total mata kuliah'.padRight(18)}: ${manager.jumlahData}');
  print('${'Total SKS'.padRight(18)}: ${manager.hitungTotalSks()}');
  print(
    '${'Rata-rata SKS'.padRight(18)}: '
    '${manager.hitungRataRataSks().toStringAsFixed(2)}',
  );
  print('${'Daftar kode'.padRight(18)}: ${manager.daftarKode().join(', ')}');
  print(garisPendek);
  print('Ringkasan jenis');

  if (ringkasan.isEmpty) {
    print('${'Belum ada data'.padRight(18)}: -');
  } else {
    ringkasan.forEach((jenis, jumlah) {
      print('${jenis.padRight(18)}: $jumlah');
    });
  }

  print(garisPendek);
}

void tampilkanDaftar(String judul, List<MataKuliah> daftar) {
  tampilkanJudul(judul);

  if (daftar.isEmpty) {
    tampilkanPesan('INFO', 'Data tidak ditemukan.');
    print(garisPendek);
    return;
  }

  print(
    '${'No'.padRight(5)}'
    '${'Kode'.padRight(10)}'
    '${'Nama'.padRight(34)}'
    '${'Jenis'.padRight(12)}'
    '${'SKS'.padRight(8)}'
    'Keterangan',
  );
  print(garisPendek);

  for (int i = 0; i < daftar.length; i++) {
    MataKuliah mataKuliah = daftar[i];

    print(
      '${'${i + 1}.'.padRight(5)}'
      '${mataKuliah.kode.padRight(10)}'
      '${potongTeks(mataKuliah.nama, 32).padRight(34)}'
      '${mataKuliah.jenis.padRight(12)}'
      '${'${mataKuliah.sks} SKS'.padRight(8)}'
      '${potongTeks(mataKuliah.keterangan, 18)}',
    );
  }

  print(garisPendek);
  print('${'Total data'.padRight(18)}: ${daftar.length}');
  print(garisPendek);
}

void tampilkanJudul(String judul) {
  print(garis);
  print(judul.padLeft(45));
  print(garis);
}

void tampilkanPesan(String status, String pesan) {
  print('${status.padRight(8)}: $pesan');
}

String bacaInput(String label) {
  stdout.write('${label.padRight(18)}: ');
  String nilai = stdin.readLineSync()?.trim() ?? '';

  if (nilai.isEmpty) {
    throw DataTidakValidException('$label tidak boleh kosong.');
  }

  return nilai;
}

int bacaAngka(String label) {
  String input = bacaInput(label);
  int? angka = int.tryParse(input);

  if (angka == null) {
    throw DataTidakValidException('$label harus berupa angka.');
  }

  return angka;
}

String potongTeks(String teks, int batas) {
  if (teks.length <= batas) {
    return teks;
  }

  return '${teks.substring(0, batas - 3)}...';
}
