import 'dart:convert';
import 'package:http/http.dart' as http;

class Gempa {
  final String tanggal;
  final String jam;
  final String datetime;
  final String coordinates;
  final double latitude;
  final double longitude;
  final double magnitude;
  final int kedalaman;
  final String wilayah;
  final String potensi;
  final String dirasakan;
  final String shaksmap;

  Gempa({
    required this.tanggal,
    required this.jam,
    required this.datetime,
    required this.coordinates,
    required this.latitude,
    required this.longitude,
    required this.magnitude,
    required this.kedalaman,
    required this.wilayah,
    required this.potensi,
    required this.dirasakan,
    required this.shaksmap,
  });

  factory Gempa.fromJson(Map<String, dynamic> json) {
    final String koord = json['Coordinates'] ?? '0,0';
    final List<String> coords = koord.split(',');

    return Gempa(
      tanggal: json['Tanggal'] ?? '-',
      jam: json['Jam'] ?? '-',
      datetime: json['DateTime'] ?? '-',
      coordinates: koord,
      latitude: double.tryParse(coords[0].trim()) ?? 0.0,
      longitude: double.tryParse(coords[1].trim()) ?? 0.0,
      magnitude: double.tryParse(json['Magnitude'] ?? '0.0') ?? 0.0,
      kedalaman: int.tryParse(
              (json['Kedalaman'] ?? '0 km').replaceAll(' km', '').trim()) ??
          0,
      wilayah: json['Wilayah'] ?? 'Tidak diketahui',
      potensi: json['Potensi'] ?? 'Tidak berpotensi Tsunami',
      dirasakan: json['Dirasakan'] ?? '-',
      shaksmap: json['Shakemap'] ?? '',
    );
  }
}
