import '../exceptions/data_tidak_valid_exception.dart';
import 'mata_kuliah.dart';

class MataKuliahWajib extends MataKuliah {
  late int _semester;

  MataKuliahWajib({
    required String kode,
    required String nama,
    required int sks,
    required int semester,
  }) : super(kode: kode, nama: nama, sks: sks) {
    this.semester = semester;
  }

  int get semester => _semester;

  set semester(int value) {
    if (value <= 0 || value > 8) {
      throw DataTidakValidException(
        'Semester harus berada di antara 1 sampai 8.',
      );
    }
    _semester = value;
  }

  @override
  String get jenis => 'Wajib';

  @override
  String get keterangan => 'Semester $semester';
}
