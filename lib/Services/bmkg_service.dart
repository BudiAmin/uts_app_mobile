import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/gempa_model.dart';

class BmkgService {
  static const String _baseUrl =
      'https://data.bmkg.go.id/DataMKG/TEWS/autogempa.json';

  Future<Gempa> fetchLatestGempa() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final gempaData = data['Infogempa']['gempa'];
        return Gempa.fromJson(gempaData);
      } else {
        throw Exception(
            'Failed to load data, status code: ${response.statusCode}');
      }
    } catch (e) {
      return Gempa(
        tanggal: 'Error',
        jam: 'Error',
        datetime: 'Error',
        coordinates: 'Error',
        latitude: 0.0,
        longitude: 0.0,
        magnitude: 0.0,
        kedalaman: 0,
        wilayah: 'Gagal mengambil data dari BMKG. Cek koneksi internet.',
        potensi: 'Silakan coba lagi',
        dirasakan: '',
        shaksmap: '',
      );
    }
  }
}
