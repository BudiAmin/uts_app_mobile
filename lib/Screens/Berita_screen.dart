import 'package:flutter/material.dart';
import '../Models/berita_model.dart';

class BeritaScreen extends StatelessWidget {
  const BeritaScreen({Key? key}) : super(key: key);

  static final List<News> newsList = [
    News(
      title: 'Perkembangan Teknologi AI Semakin Pesat di Indonesia',
      source: 'Tech News',
      time: '2 jam lalu',
      category: 'Teknologi',
      icon: Icons.computer,
      categoryColor: Colors.blue,
    ),
    News(
      title: 'Ekonomi Digital Indonesia Tumbuh 20% di Tahun 2025',
      source: 'Bisnis Today',
      time: '3 jam lalu',
      category: 'Ekonomi',
      icon: Icons.trending_up,
      categoryColor: Colors.green,
    ),
    News(
      title: 'Tim Nasional Indonesia Raih Medali Emas di Ajang Internasional',
      source: 'Sports Daily',
      time: '5 jam lalu',
      category: 'Olahraga',
      icon: Icons.sports_soccer,
      categoryColor: Colors.orange,
    ),
    News(
      title:
          'Penemuan Vaksin Baru Memberikan Harapan untuk Kesehatan Masyarakat',
      source: 'Health Magazine',
      time: '6 jam lalu',
      category: 'Kesehatan',
      icon: Icons.health_and_safety,
      categoryColor: Colors.red,
    ),
    News(
      title:
          'Peluncuran Satelit Baru Meningkatkan Konektivitas Internet Nasional',
      source: 'Space News',
      time: '8 jam lalu',
      category: 'Sains',
      icon: Icons.science,
      categoryColor: Colors.purple,
    ),
    News(
      title: 'Kebijakan Pendidikan Baru Fokus pada Digitalisasi Pembelajaran',
      source: 'Edu Portal',
      time: '10 jam lalu',
      category: 'Pendidikan',
      icon: Icons.school,
      categoryColor: Colors.indigo,
    ),
    News(
      title: 'Festival Budaya Nusantara Dihadiri Ribuan Pengunjung',
      source: 'Culture Today',
      time: '12 jam lalu',
      category: 'Budaya',
      icon: Icons.palette,
      categoryColor: Colors.teal,
    ),
    News(
      title: 'Startup Indonesia Raih Pendanaan 100 Miliar Rupiah',
      source: 'Startup News',
      time: '1 hari lalu',
      category: 'Bisnis',
      icon: Icons.business,
      categoryColor: Colors.cyan,
    ),
    News(
      title: 'Program Reboisasi Berhasil Tanam 1 Juta Pohon',
      source: 'Green World',
      time: '1 hari lalu',
      category: 'Lingkungan',
      icon: Icons.eco,
      categoryColor: Colors.lightGreen,
    ),
    News(
      title: 'Konser Musik Indie Sukses Digelar di Jakarta',
      source: 'Entertainment Weekly',
      time: '2 hari lalu',
      category: 'Hiburan',
      icon: Icons.music_note,
      categoryColor: Colors.pink,
    ),
    News(
      title: 'Inovasi Transportasi Umum dengan Teknologi Ramah Lingkungan',
      source: 'Transport News',
      time: '2 hari lalu',
      category: 'Transportasi',
      icon: Icons.directions_bus,
      categoryColor: Colors.amber,
    ),
    News(
      title: 'Peneliti Temukan Metode Baru untuk Pengolahan Sampah Plastik',
      source: 'Science Daily',
      time: '3 hari lalu',
      category: 'Sains',
      icon: Icons.recycling,
      categoryColor: Colors.brown,
    ),
    News(
      title: 'E-Sports Indonesia Masuk 10 Besar Dunia',
      source: 'Gaming News',
      time: '3 hari lalu',
      category: 'Gaming',
      icon: Icons.sports_esports,
      categoryColor: Colors.deepPurple,
    ),
    News(
      title: 'Pameran Kuliner Nusantara Hadirkan 100 Menu Tradisional',
      source: 'Food Magazine',
      time: '4 hari lalu',
      category: 'Kuliner',
      icon: Icons.restaurant,
      categoryColor: Colors.deepOrange,
    ),
    News(
      title: 'Aplikasi Mobile Banking Terbaru Dengan Fitur AI Assistant',
      source: 'Finance Today',
      time: '5 hari lalu',
      category: 'Finansial',
      icon: Icons.account_balance,
      categoryColor: Colors.blueGrey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade50, Colors.white],
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Icon(Icons.article, size: 30, color: Colors.blue),
                const SizedBox(width: 10),
                const Text(
                  'Berita Terkini',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {},
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          // News List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(news.title),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(news.icon,
                                      size: 20, color: news.categoryColor),
                                  const SizedBox(width: 5),
                                  Text(
                                    news.category,
                                    style: TextStyle(
                                      color: news.categoryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text('Sumber: ${news.source}'),
                              Text('Waktu: ${news.time}'),
                              const SizedBox(height: 15),
                              const Text(
                                'Ini adalah konten detail berita yang akan ditampilkan. Dalam implementasi nyata, konten ini akan diambil dari API atau database.',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Tutup'),
                            ),
                          ],
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category Icon
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: news.categoryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              news.icon,
                              size: 28,
                              color: news.categoryColor,
                            ),
                          ),
                          const SizedBox(width: 12),

                          // News Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category Tag
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: news.categoryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    news.category,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: news.categoryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Title
                                Text(
                                  news.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                // Source and Time
                                Row(
                                  children: [
                                    Text(
                                      news.source,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      news.time,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
