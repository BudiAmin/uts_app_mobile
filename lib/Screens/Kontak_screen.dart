import 'package:flutter/material.dart';
import '../models/Kontak_model.dart';

class KontakScreen extends StatelessWidget {
  const KontakScreen({Key? key}) : super(key: key);

  static final List<Kontak> contacts = [
    Kontak(
      name: 'Ahmad Rizki',
      phone: '+62 812-3456-7890',
      email: 'ahmad.rizki@email.com',
      avatar: Icons.person,
      color: Colors.blue,
    ),
    Kontak(
      name: 'Siti Nurhaliza',
      phone: '+62 813-4567-8901',
      email: 'siti.nur@email.com',
      avatar: Icons.person,
      color: Colors.pink,
    ),
    Kontak(
      name: 'Budi Santoso',
      phone: '+62 814-5678-9012',
      email: 'budi.santoso@email.com',
      avatar: Icons.person,
      color: Colors.green,
    ),
    Kontak(
      name: 'Dewi Lestari',
      phone: '+62 815-6789-0123',
      email: 'dewi.lestari@email.com',
      avatar: Icons.person,
      color: Colors.orange,
    ),
    Kontak(
      name: 'Eko Prasetyo',
      phone: '+62 816-7890-1234',
      email: 'eko.prasetyo@email.com',
      avatar: Icons.person,
      color: Colors.purple,
    ),
    Kontak(
      name: 'Fitri Handayani',
      phone: '+62 817-8901-2345',
      email: 'fitri.handayani@email.com',
      avatar: Icons.person,
      color: Colors.teal,
    ),
    Kontak(
      name: 'Galih Wicaksono',
      phone: '+62 818-9012-3456',
      email: 'galih.wicaksono@email.com',
      avatar: Icons.person,
      color: Colors.indigo,
    ),
    Kontak(
      name: 'Hana Pertiwi',
      phone: '+62 819-0123-4567',
      email: 'hana.pertiwi@email.com',
      avatar: Icons.person,
      color: Colors.red,
    ),
    Kontak(
      name: 'Irfan Hakim',
      phone: '+62 820-1234-5678',
      email: 'irfan.hakim@email.com',
      avatar: Icons.person,
      color: Colors.amber,
    ),
    Kontak(
      name: 'Julia Kartika',
      phone: '+62 821-2345-6789',
      email: 'julia.kartika@email.com',
      avatar: Icons.person,
      color: Colors.cyan,
    ),
    Kontak(
      name: 'Kevin Anggara',
      phone: '+62 822-3456-7890',
      email: 'kevin.anggara@email.com',
      avatar: Icons.person,
      color: Colors.deepOrange,
    ),
    Kontak(
      name: 'Linda Permata',
      phone: '+62 823-4567-8901',
      email: 'linda.permata@email.com',
      avatar: Icons.person,
      color: Colors.deepPurple,
    ),
    Kontak(
      name: 'Muhammad Fajar',
      phone: '+62 824-5678-9012',
      email: 'muhammad.fajar@email.com',
      avatar: Icons.person,
      color: Colors.lightBlue,
    ),
    Kontak(
      name: 'Nadia Rahmawati',
      phone: '+62 825-6789-0123',
      email: 'nadia.rahmawati@email.com',
      avatar: Icons.person,
      color: Colors.lightGreen,
    ),
    Kontak(
      name: 'Oscar Wijaya',
      phone: '+62 826-7890-1234',
      email: 'oscar.wijaya@email.com',
      avatar: Icons.person,
      color: Colors.brown,
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
                const Icon(Icons.contacts, size: 30, color: Colors.blue),
                const SizedBox(width: 10),
                const Text(
                  'Daftar Kontak',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${contacts.length} Kontak',
                    style: TextStyle(
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List Kontak
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Hero(
                      tag: 'contact_$index',
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: contact.color.withOpacity(0.2),
                        child: Icon(
                          contact.avatar,
                          color: contact.color,
                          size: 28,
                        ),
                      ),
                    ),
                    title: Text(
                      contact.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.phone,
                                size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 5),
                            Text(
                              contact.phone,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.email,
                                size: 14, color: Colors.grey.shade600),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                contact.email,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.phone, color: Colors.green.shade600),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Memanggil ${contact.name}...'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon:
                              Icon(Icons.message, color: Colors.blue.shade600),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Mengirim pesan ke ${contact.name}...'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                      ],
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
