import 'package:flutter/material.dart';

class SidebarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sidebar Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Menu 1'),
              onTap: () {
                // Tambahkan logika untuk menavigasi ke halaman tertentu saat menu dipilih
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              title: Text('Menu 2'),
              onTap: () {
                // Tambahkan logika untuk menavigasi ke halaman tertentu saat menu dipilih
                Navigator.pop(context); // Tutup drawer
              },
            ),
            // Tambahkan menu lain sesuai kebutuhan Anda
          ],
        ),
      ),
      body: Center(
        child: Text('Konten Sidebar'),
      ),
    );
  }
}
