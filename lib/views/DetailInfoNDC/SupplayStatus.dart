import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class SupplayStatus extends StatelessWidget {
  final String atmid;
  List<String> column1Data = [
    "Cash Reject Bin",
    "Receipt Paper",
    "Statement Paper",
    "Deposit Bin",
    "Journal Paper",
    "Card Capture Bin",
    "Cassete 1",
  ];

  List<String> column2Data = [
    "", 
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  SupplayStatus({Key? key, required this.atmid}) : super(key: key);


Future<Map<String, dynamic>> fetchData() async {
  final apiUrl = 'http://10.10.7.9:8083/emon-ws/emonmbl/detailststermndc?atmid=$atmid';
print('ATM id suplly status: $atmid');
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final dynamic decodedResponse = jsonDecode(response.body);

      if (decodedResponse is List<dynamic> && decodedResponse.isNotEmpty) {
        final Map<String, dynamic> data = decodedResponse.first['myHashMap'];
        return data;
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
                  'Supply Status',
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

                  column2Data = [
                    data['rejectbin'].toString(),
                    data['receiptpaper'].toString(),
                    data['stmpaper'].toString(),
                    data['depositbin'].toString(),
                    data['journalpaper'].toString(),
                    data['cardbin'].toString(),
                    data['casssup1'].toString(),
                  ];

                  return TwoColumnTable2(column1: column1Data, column2: column2Data);
                }
              },
            ),
          ),
                  
        ],
      ),
    );
  }
}
