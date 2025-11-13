import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Splash_screen.dart';
import 'kalkulator_screen.dart';
import 'Berita_screen.dart';
import 'Biodata_screen.dart';
import 'Gempa_screen.dart';
import 'Kontak_screen.dart';
import 'Cuaca_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _fragments = [
    const BiodataScreen(),
    const KontakScreen(),
    const KalkulatorScreen(),
    const BeritaScreen(),
    const CuacaScreen(),
    const GempaScreen(),
  ];

  final List<IconData> _navIcons = [
    Icons.person,
    Icons.contacts,
    Icons.calculate,
    Icons.article,
    Icons.wb_sunny,
    Icons.public,
  ];

  final List<String> _titles = const [
    'Profil Mahasiswa',
    'Daftar Kontak',
    'Kalkulator',
    'Berita Terkini',
    'Info Cuaca',
    'Info Gempa BMKG',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color darkGreen = Colors.green.shade800;
    final Color mediumGreen = Colors.green.shade600;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(_navIcons[_selectedIndex], color: Colors.white),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [darkGreen, mediumGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _fragments[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: darkGreen,
        buttonBackgroundColor: mediumGreen,
        height: 60,
        animationDuration: const Duration(milliseconds: 400),
        items: _navIcons
            .map(
              (icon) => Icon(
                icon,
                size: 28,
                color: Colors.white,
              ),
            )
            .toList(),
        onTap: _onItemTapped,
      ),
    );
  }
}
