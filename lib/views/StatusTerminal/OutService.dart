// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/DetailInfoDDC/DetailDDC.dart';
import 'package:flutter_application_1/views/DetailInfoNDC/DetailNDC.dart';
import 'package:flutter_application_1/views/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OutServicePage extends StatelessWidget {
  const OutServicePage({Key? key});

  Future<List<Map<String, dynamic>>?> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.10.7.9:8083/emon-ws/emonmbl/termstatus?status=6'));

      if (response.statusCode == 200) {
        if (response.body != null) {
          final dynamic decodedResponse = jsonDecode(response.body);

          if (decodedResponse is List<dynamic>) {
            final List<dynamic> dataList = decodedResponse;

            List<Map<String, dynamic>> data = [];

            int counter = 1;

            for (var entry in dataList) {
              final atmid = entry['atmid'];
              final branchName = entry['branchname'];
              final msgFmt = entry['msgfmt'];

              data.add({
                'no': counter.toString(),
                'atmid': atmid?.toString() ?? '',
                'branchname': branchName?.toString() ?? '',
                'msgfmt': msgFmt?.toString() ?? '',
              });

              counter++;
            }

            return data;
          } else {
            print('Error: Response body is not a List<dynamic>.');
            return null;
          }
        } else {
          print('Error: Response body is null.');
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

void _navigateToDetailPage(BuildContext context, String msgFmt, String atmid){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      if (msgFmt == 'NDC') {
        return DetailNDC(atmid: atmid); 
      } else if (msgFmt == 'DDC') {
        return DetailDDC(atmid: atmid); 
      } else {
        return DefaultDetailPage();
      }
    }),
  );
}


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>>? data = snapshot.data;
            return Stack(
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
                      Text('Out Service', style: MyTextStyles.style8),
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
                  top: 140,
                  left: 35,
                  right: 35,
                  child: Container(
                    width: 275,
                    height: 198,
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((states) {
                        return Colors.orange;
                      }),
                      dataRowColor: MaterialStateColor.resolveWith((states) {
                        return const Color.fromARGB(255, 255, 255, 255);
                      }),
                      dataTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
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
                            child: Text('Nama Cabang', style: whiteTextStyle),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 67,
                            alignment: Alignment.center,
                            child: Text('ID ATM', style: whiteTextStyle),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 67,
                            alignment: Alignment.center,
                            child: Text('Format', style: whiteTextStyle),
                          ),
                        ),
                      ],
                      rows: data != null && data.isNotEmpty
                          ? data.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Container(
                                      width: 40,
                                      child: Text(
                                        item['no']!,
                                        style: MyTextStyles.style12,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 116,
                                      child: Text(
                                        item['branchname']!,
                                        style: MyTextStyles.style12,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 67,
                                      child: Text(
                                        item['atmid']!,
                                        style: MyTextStyles.style12,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    Container(
                                      width: 67,
                                      child: GestureDetector(
                                        onTap: () => _navigateToDetailPage(context, item['msgfmt']!,item['atmid']!), //tambahin id
                                        child: Text(
                                          item['msgfmt']!,
                                          style: MyTextStyles.style12,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList()
                          : [],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class DefaultDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Default'),
      ),
      body: Center(
        child: Text('Detail Default'),
      ),
    );
  }
}