import 'package:flutter/material.dart';
import 'dart:async';
import '../Models/gempa_model.dart';
import '../Services/bmkg_service.dart';

class GempaScreen extends StatefulWidget {
  const GempaScreen({Key? key}) : super(key: key);

  @override
  State<GempaScreen> createState() => _GempaScreenState();
}

class _GempaScreenState extends State<GempaScreen> {
  final BmkgService _bmkgService = BmkgService();
  Gempa? _latestGempa;
  bool _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchGempaData();
    _timer = Timer.periodic(
        const Duration(minutes: 10), (Timer t) => _fetchGempaData());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchGempaData() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final gempa = await _bmkgService.fetchLatestGempa();
      if (mounted) {
        setState(() {
          _latestGempa = gempa;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil data gempa: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color lightGreen = Colors.lightGreen.shade200;
    final Color mediumGreen = Colors.green.shade600;
    final Color darkGreen = Colors.green.shade800;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                lightGreen,
                Colors.white,
              ],
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Info Gempa',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: darkGreen,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Data Real-time BMKG',
                            style: TextStyle(
                              fontSize: 14,
                              color: mediumGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: darkGreen.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: _isLoading
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(darkGreen),
                                ),
                              )
                            : Icon(Icons.refresh_rounded,
                                color: darkGreen, size: 26),
                        onPressed: _isLoading ? null : _fetchGempaData,
                      ),
                    ),
                  ],
                ),
              ),
              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_latestGempa == null && !_isLoading)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(40),
                            child: Column(
                              children: [
                                Icon(Icons.info_outline,
                                    size: 60, color: Colors.grey.shade400),
                                const SizedBox(height: 15),
                                Text(
                                  'Data gempa tidak tersedia.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (_isLoading)
                        _buildLoadingCard(darkGreen)
                      else
                        Column(
                          children: [
                            _buildMainCard(
                                mediumGreen, darkGreen, _latestGempa!),
                            const SizedBox(height: 20),
                            _buildDetailGrid(darkGreen, _latestGempa!),
                            const SizedBox(height: 20),
                            _buildPotensiCard(darkGreen, _latestGempa!),
                            const SizedBox(height: 20),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainCard(Color mediumGreen, Color darkGreen, Gempa gempa) {
    return Card(
      elevation: 12,
      shadowColor: darkGreen.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Container(
        padding: const EdgeInsets.all(35),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [mediumGreen, darkGreen],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'M ${gempa.magnitude.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 68,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                gempa.wilayah,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time_rounded,
                    color: Colors.white.withOpacity(0.9), size: 18),
                const SizedBox(width: 8),
                Text(
                  '${gempa.tanggal} | ${gempa.jam}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailGrid(Color darkGreen, Gempa gempa) {
    String waktuGempa = '';
    try {
      if (gempa.datetime.contains(' ')) {
        waktuGempa = gempa.datetime.split(' ')[1].substring(0, 5);
      } else {
        waktuGempa = gempa.datetime.substring(11, 16);
      }
    } catch (e) {
      waktuGempa = '00:00';
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: [
        _buildInfoCard(
          icon: Icons.trending_down_rounded,
          label: 'Kedalaman',
          value: '${gempa.kedalaman} km',
          color: darkGreen,
        ),
        _buildInfoCard(
          icon: Icons.location_on_rounded,
          label: 'Koordinat',
          value: gempa.coordinates,
          color: Colors.teal.shade600,
        ),
        _buildInfoCard(
          icon: Icons.public_rounded,
          label: 'Dirasakan',
          value: gempa.dirasakan.isNotEmpty
              ? gempa.dirasakan.replaceAll('Felt', 'Dirasakan')
              : 'Tidak ada laporan',
          color: darkGreen,
        ),
        _buildInfoCard(
          icon: Icons.update_rounded,
          label: 'Diperbarui',
          value: 'Setiap 10 Menit\n$waktuGempa WIB',
          color: Colors.teal.shade600,
        ),
      ],
    );
  }

  Widget _buildPotensiCard(Color darkGreen, Gempa gempa) {
    bool isTsunami = gempa.potensi.toLowerCase().contains('tsunami');
    return Card(
      elevation: 6,
      shadowColor:
          (isTsunami ? Colors.red.shade400 : darkGreen).withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isTsunami ? Colors.red.shade400 : darkGreen,
          width: 2.5,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isTsunami
                  ? Colors.red.shade50
                  : Colors.lightGreen.shade50.withOpacity(0.5),
              Colors.white,
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    (isTsunami ? Colors.red.shade100 : Colors.green.shade100),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                isTsunami
                    ? Icons.warning_amber_rounded
                    : Icons.verified_rounded,
                color: isTsunami ? Colors.red.shade700 : darkGreen,
                size: 32,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Potensi Tsunami',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: darkGreen,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    gempa.potensi,
                    style: TextStyle(
                      fontSize: 14,
                      color: isTsunami ? Colors.red.shade700 : Colors.black87,
                      fontWeight:
                          isTsunami ? FontWeight.w600 : FontWeight.normal,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shadowColor: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingCard(Color darkGreen) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: darkGreen.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CircularProgressIndicator(
                strokeWidth: 3.5,
                valueColor: AlwaysStoppedAnimation<Color>(darkGreen),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Mengambil data gempa...',
              style: TextStyle(
                color: darkGreen,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
