import '../exceptions/data_tidak_valid_exception.dart';
import 'mata_kuliah.dart';

class MataKuliahPilihan extends MataKuliah {
  late String _minat;

  MataKuliahPilihan({
    required String kode,
    required String nama,
    required int sks,
    required String minat,
  }) : super(kode: kode, nama: nama, sks: sks) {
    this.minat = minat;
  }

  String get minat => _minat;

  set minat(String value) {
    if (value.trim().isEmpty) {
      throw DataTidakValidException('Bidang minat tidak boleh kosong.');
    }
    _minat = value.trim();
  }

  @override
  String get jenis => 'Pilihan';

  @override
  String get keterangan => minat;
}
