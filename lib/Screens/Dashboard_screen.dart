import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'Splash_screen.dart';
import 'kalkulator_screen.dart';
import 'Berita_screen.dart';
import 'Biodata_screen.dart';
import 'Cuaca_screen.dart';
import 'Kontak_screen.dart';

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
    const CuacaScreen(),
    const BeritaScreen(),
  ];

  final List<IconData> _navIcons = [
    Icons.person,
    Icons.contacts,
    Icons.calculate,
    Icons.cloud,
    Icons.article,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // agar efek curved terlihat bagus di atas background
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            // Kembali ke SplashScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            );
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.cyan.shade400],
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

      // Curved Navigation Bar
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.transparent,
        color: Colors.blue.shade700,
        buttonBackgroundColor: Colors.cyan.shade400,
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
