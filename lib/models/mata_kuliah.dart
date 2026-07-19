import '../exceptions/data_tidak_valid_exception.dart';

abstract class MataKuliah {
  late String _kode;
  late String _nama;
  late int _sks;

  MataKuliah({
    required String kode,
    required String nama,
    required int sks,
  }) {
    this.kode = kode;
    this.nama = nama;
    this.sks = sks;
  }

  String get kode => _kode;
  String get nama => _nama;
  int get sks => _sks;

  set kode(String value) {
    if (value.trim().isEmpty) {
      throw DataTidakValidException('Kode mata kuliah tidak boleh kosong.');
    }
    _kode = value.trim().toUpperCase();
  }

  set nama(String value) {
    if (value.trim().isEmpty) {
      throw DataTidakValidException('Nama mata kuliah tidak boleh kosong.');
    }
    _nama = value.trim();
  }

  set sks(int value) {
    if (value <= 0) {
      throw DataTidakValidException('SKS harus lebih dari 0.');
    }
    _sks = value;
  }

  String get jenis;

  String get keterangan;
}
