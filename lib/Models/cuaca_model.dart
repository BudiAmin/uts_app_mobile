class CuacaModel {
  final String lokasi;
  final String provinsi;
  final String kondisi;
  final String suhu;
  final String tanggal;
  final String kelembapan;
  final String kecepatanAngin;
  final String jarakPandang;
  final String tekanan;
  final List<Map<String, dynamic>> prakiraan7Hari;

  CuacaModel({
    required this.lokasi,
    required this.provinsi,
    required this.kondisi,
    required this.suhu,
    required this.tanggal,
    required this.kelembapan,
    required this.kecepatanAngin,
    required this.jarakPandang,
    required this.tekanan,
    required this.prakiraan7Hari,
  });
}
