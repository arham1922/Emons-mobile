import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/Host/HostDetail.dart';
import 'package:flutter_application_1/views/utils.dart';
import 'package:http/http.dart' as http;

class SignOnPage extends StatelessWidget {
  final String status;

  SignOnPage({required this.status});

  Future<List<Map<String, dynamic>>?> fetchData(String status) async {
    try {
      final response = await http.get(Uri.parse('http://10.10.7.9:8083/emon-ws/emonmbl/datahoststatus?status=$status'));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final dynamic decodedResponse = jsonDecode(response.body);

          if (decodedResponse is List<dynamic>) {
            final List<dynamic> dataList = decodedResponse;

            List<Map<String, dynamic>> data = [];

            int counter = 1;

            for (var entry in dataList) {
              final profile = entry['profile'];
              final caseValue = entry['case'];

              data.add({
                'no': counter.toString(),
                'profile': profile?.toString() ?? '',
                'case': caseValue?.toString() ?? '',
              });

              counter++;
            }

            return data;
          } else {
            print('Error: Response body is not a List<dynamic>.');
            return null;
          }
        } else {
          print('Error: Response body is null or empty.');
          return null;
        }
      } else {
        throw Exception('Gagal mengambil data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error accessing API: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('status:$status');
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
                  'Sign On',
                  style: MyTextStyles.style8,
                ),
              ],
            ),
          ),
          Positioned(
            top: 125,
            left: 20,
            right: 20,
            child: Container(
              width: 350,
              height: 640,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 35,
            right: 35,
            child: FutureBuilder<List<Map<String, dynamic>>?>(
              future: fetchData(status),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('Data kosong.');
                } else {
                  return Container(
                    width: 275,
                    height: 198,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.orange),
                      dataRowColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 255, 255, 255)),
                      dataTextStyle: const TextStyle(color: Colors.black, fontSize: 13, fontFamily: 'Poppins', fontWeight: FontWeight.w400, height: 0),
                      headingRowHeight: 40,
                      horizontalMargin: 0,
                      columnSpacing: 0,
                      dataRowHeight: 50,
                      columns: [
                        DataColumn(
                          label: Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: Text(
                              'No',
                              style: whiteTextStyle,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 116,
                            alignment: Alignment.center,
                            child: Text('Host Profile', style: whiteTextStyle),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 67,
                            alignment: Alignment.center,
                            child: Text('Status', style: whiteTextStyle),
                          ),
                        ),
                      ],
                      rows: snapshot.data!.map((rowData) {
                        return DataRow(cells: [
                        DataCell(Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Text(rowData['no']!),
                        )),
                        DataCell(Container(
                          width: 116,
                          alignment: Alignment.center,
                          child: Text(rowData['profile']!),
                        )),
                        DataCell(
                          Container(
                            height: 25,
                            width: 60,
                            decoration: BoxDecoration(
                              color: getColorForCase(rowData['case']!),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => HostDetailPage(profile: rowData['profile']),),);},
                               
                                child: Text(
                                  'Sign On',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]);

                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

Color getColorForStatus(String status) {
  if (status == 'Sign On') {
    return Color(0xFF3DD34C);
  } else {
    return Colors.grey;
  }
}
