import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/DetailInfoDDC/DaftarTransaksiDDC.dart';
import 'package:flutter_application_1/views/DetailInfoDDC/HardwareStatusDDC.dart';
import 'package:flutter_application_1/views/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DetailDDC extends StatelessWidget {
  final String atmid;
  List<String> column1Data = [
    "Profile Terminal",
    "Luno",
    "Merk Terminal",
    "Cabang",
    "Lokasi",
    "Denom",
    "IP Address",
    "Port",
    "Terminal Status",
  ];

  List<String> column2Data = [
    "", 
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  DetailDDC({Key? key, required this.atmid}) : super(key: key);


Future<Map<String, dynamic>> fetchData() async {
  final apiUrl = 'http://10.10.7.9:8083/emon-ws/emonmbl/detailterm?atmid=$atmid';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final dynamic decodedResponse = jsonDecode(response.body);

      if (decodedResponse is List<dynamic> && decodedResponse.isNotEmpty) {
        final Map<String, dynamic> data = decodedResponse.first;
        return data;
      } else if (decodedResponse is Map<String, dynamic>) {
        return decodedResponse;
      } else {
        throw Exception('Struktur respons tidak valid');
      }
    } else {
      throw Exception('Gagal mengambil data: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error accessing API: $e');
    throw Exception('Gagal mengambil data: $e');
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo/BackgroundHeader.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: IconButton(
              icon: Image.asset('assets/icon/back.png', width: 19, height: 16),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 90),
                Text(
                  'Info Terminal',
                  style: MyTextStyles.style8,
                ),
              ],
            ),
          ),
          Positioned(
            top: 125,
            left: 20,
            right: 20,
            child: MyContainer.getContainerBesar(),
          ),
          Positioned(
            top: 135,
            left: 30,
            right: 30,
            child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;

                  // Update data sesuai dengan kunci API yang sesuai
                  column2Data = [
                    data['atmname'].toString(),
                    data['atmid'].toString(),
                    data['brandname'].toString(),
                    data['branchname'].toString(),
                    data['location'].toString(),
                    data['denomination'].toString(),
                    data['ip'].toString(),
                    data['port'].toString(),
                    data['status'].toString(),
                  ];

                  return TwoColumnTable(column1: column1Data, column2: column2Data);
                }
              },
            ),
          ),
          Positioned(
            bottom: 80,
            left: 110,
            right: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                button(
                  width: 70,
                  height: 38,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HardwareStatusDDC(),));
                  },
                  child: Text('Hardware Status', textAlign: TextAlign.center, style: MyTextStyles.style7,),
                ),
                button(
                  width: 70,
                  height: 38,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DaftarTransaksiDDC(),));
                  },
                  child: Text('Daftar Transaksi', textAlign: TextAlign.center, style: MyTextStyles.style7,),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
