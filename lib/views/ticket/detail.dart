import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/ticket/update.dart';
import 'package:flutter_application_1/views/utils.dart';

void main() {
  runApp(DetailPage());
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFDE1F27), Color(0xFFFA913B)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text('Detail Ticket', style: MyTextStyles.style17),
          actions: [
            IconButton(
              icon: Icon(Icons.update),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage()));
                print('Update button pressed');
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
            ),
            SizedBox(height: 30),
            Container(
              width: 290,
              height: 650,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: 20),
                    TwoColumnTable3(
                      column1: [
                        'Status',
                        'No Ticket',
                        'ATM Id',
                        'Bank',
                        'Lokasi',
                        'Merk Mesin',
                        'Type Mesin',
                        'Serial Number',
                        'Waktu Pelaksanaan',
                        'Tanggal Pelaksanaan',
                        'Petugas',
                        'Analisa Perbaikan',
                      ],
                      column2: [
                        'DONE',
                        'A012',
                        'ATM045',
                        'Mandiri',
                        'Bandung',
                        'Wincor',
                        'Procash',
                        '231231',
                        '15-12-2023',
                        '15-12-2023 17:00',
                        'Teknisi 13',
                        'Check And Clean All Device,Check And Clean All Device',
                      
                        
                      ],
                    ),
                    SizedBox(height: 20),
                    buildImageContainer('Foto ATM', "https://via.placeholder.com/100x94"),
                    buildImageContainer('Foto Struk', "https://via.placeholder.com/100x94"),
                    buildImageContainer('Foto Part', "https://via.placeholder.com/100x94"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



Widget buildImageContainer(String label, String imageUrl) {
  return Container(
    width: 285,
    height: 135,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: Container(
            width: 120,
            height: 135,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 120,
                    height: 135,
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
                Positioned(
                  left: 5,
                  top: 33.75,
                  child: SizedBox(
                    width: 40,
                    height: 67.50,
                    child: Text(
                      label,
                      style: MyTextStyles.style4
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 128,
          top: 7,
          child: Container(
            width: 157,
            height: 94.25,
            child: Stack(
              children: [
                Positioned(
                  left: 28,
                  top: 0,
                  child: Container(
                    width: 100,
                    height: 93.75,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 26.75,
                  child: SizedBox(
                    width: 157,
                    height: 67.50,
                    child: Text(
                      ':  ',
                      style: MyTextStyles.style4
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
