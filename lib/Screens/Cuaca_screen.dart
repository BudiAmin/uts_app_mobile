import 'package:flutter/material.dart';
import '../models/cuaca_model.dart';

class CuacaScreen extends StatefulWidget {
  const CuacaScreen({Key? key}) : super(key: key);

  @override
  State<CuacaScreen> createState() => _CuacaScreenState();
}

class _CuacaScreenState extends State<CuacaScreen> {
  late CuacaModel cuaca;

  @override
  void initState() {
    super.initState();
    // Data dummy, bisa diganti dengan data dari API nantinya
    cuaca = CuacaModel(
      lokasi: 'Bandung, Indonesia',
      provinsi: 'Jawa Barat',
      kondisi: 'Cerah Berawan',
      suhu: '28°C',
      tanggal: 'Kamis, 23 Oktober 2025',
      kelembapan: '65%',
      kecepatanAngin: '12 km/h',
      jarakPandang: '10 km',
      tekanan: '1013 mb',
      prakiraan7Hari: [
        {'hari': 'Senin', 'icon': Icons.wb_sunny, 'max': '30°', 'min': '22°'},
        {'hari': 'Selasa', 'icon': Icons.cloud, 'max': '28°', 'min': '21°'},
        {'hari': 'Rabu', 'icon': Icons.grain, 'max': '26°', 'min': '20°'},
        {
          'hari': 'Kamis',
          'icon': Icons.thunderstorm,
          'max': '25°',
          'min': '19°'
        },
        {'hari': 'Jumat', 'icon': Icons.wb_cloudy, 'max': '27°', 'min': '20°'},
        {'hari': 'Sabtu', 'icon': Icons.wb_sunny, 'max': '29°', 'min': '22°'},
        {'hari': 'Minggu', 'icon': Icons.wb_sunny, 'max': '31°', 'min': '23°'},
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade200,
              Colors.cyan.shade100,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Lokasi
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on,
                          color: Colors.blue.shade700, size: 28),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cuaca.lokasi,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            cuaca.provinsi,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Kartu Cuaca Utama
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade300,
                        Colors.blue.shade500,
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        builder: (context, double value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.wb_sunny,
                                size: 80,
                                color: Colors.yellow,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        cuaca.suhu,
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        cuaca.kondisi,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        cuaca.tanggal,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Detail Cuaca
              Row(
                children: [
                  Expanded(
                    child: _buildWeatherDetailCard(
                      icon: Icons.water_drop,
                      label: 'Kelembapan',
                      value: cuaca.kelembapan,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildWeatherDetailCard(
                      icon: Icons.air,
                      label: 'Kec. Angin',
                      value: cuaca.kecepatanAngin,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildWeatherDetailCard(
                      icon: Icons.visibility,
                      label: 'Jarak Pandang',
                      value: cuaca.jarakPandang,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildWeatherDetailCard(
                      icon: Icons.compress,
                      label: 'Tekanan',
                      value: cuaca.tekanan,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Prakiraan 7 Hari
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Prakiraan 7 Hari',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      for (var item in cuaca.prakiraan7Hari)
                        _buildForecastItem(
                          item['hari'],
                          item['icon'],
                          item['max'],
                          item['min'],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherDetailCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForecastItem(
      String day, IconData icon, String maxTemp, String minTemp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              day,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Icon(icon, color: Colors.blue.shade400, size: 28),
          const Spacer(),
          Text(
            maxTemp,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '/',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            minTemp,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
