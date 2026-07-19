import '../exceptions/data_tidak_valid_exception.dart';
import '../models/mata_kuliah.dart';

class Manager {
  List<MataKuliah> _daftarMataKuliah = [];
  Set<String> _kodeTerpakai = {};

  List<MataKuliah> get semuaMataKuliah => _daftarMataKuliah;

  int get jumlahData => _daftarMataKuliah.length;

  void tambah(MataKuliah mataKuliah) {
    if (_kodeTerpakai.contains(mataKuliah.kode)) {
      throw DataTidakValidException(
        'Kode ${mataKuliah.kode} sudah digunakan.',
      );
    }

    _daftarMataKuliah.add(mataKuliah);
    _kodeTerpakai.add(mataKuliah.kode);
  }

  List<MataKuliah> cari(String keyword) {
    String kataKunci = keyword.toLowerCase();
    return _daftarMataKuliah
        .where(
          (mataKuliah) =>
              mataKuliah.nama.toLowerCase().contains(kataKunci) ||
              mataKuliah.kode.toLowerCase().contains(kataKunci) ||
              mataKuliah.jenis.toLowerCase().contains(kataKunci),
        )
        .toList();
  }

  int hitungTotalSks() {
    return _daftarMataKuliah.fold(
      0,
      (total, mataKuliah) => total + mataKuliah.sks,
    );
  }

  double hitungRataRataSks() {
    if (_daftarMataKuliah.isEmpty) {
      return 0;
    }

    return hitungTotalSks() / _daftarMataKuliah.length;
  }

  List<String> daftarKode() {
    return _daftarMataKuliah.map((mataKuliah) => mataKuliah.kode).toList();
  }

  Map<String, int> hitungJumlahPerJenis() {
    Map<String, int> ringkasan = {};

    for (MataKuliah mataKuliah in _daftarMataKuliah) {
      ringkasan[mataKuliah.jenis] = (ringkasan[mataKuliah.jenis] ?? 0) + 1;
    }

    return ringkasan;
  }

  Future<void> simpanData() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
