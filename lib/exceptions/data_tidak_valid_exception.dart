class DataTidakValidException implements Exception {
  String pesan;

  DataTidakValidException(this.pesan);

  @override
  String toString() => 'Error: $pesan';
}
