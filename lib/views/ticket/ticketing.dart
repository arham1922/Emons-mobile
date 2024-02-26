import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/ticket/create.dart';
import 'package:flutter_application_1/views/ticket/detail.dart';
import 'package:flutter_application_1/views/utils.dart';

class TicketingPage extends StatelessWidget {
  const TicketingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _horizontalController = ScrollController();

    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text('Ticketing PM', style: MyTextStyles.style17),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreatePage()),
                );
              },
              child: Container(
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFFA913B),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Center(
                  child: Text("Buat Ticket", style: MyTextStyles.style15),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horizontalController,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) {
                  return Colors.orange;
                }),
                dataRowColor: MaterialStateColor.resolveWith((states) {
                  return const Color.fromARGB(255, 255, 255, 255);
                }),
                dataTextStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
                headingRowHeight: 40,
                horizontalMargin: 20,
                columnSpacing: 20,
                dataRowHeight: 50,
                columns: [
                  DataColumn(
                      label: Center(child: Text('No', style: whiteTextStyle))),
                  DataColumn(
                      label: Center(child: Text('No Ticket', style: whiteTextStyle))),
                  DataColumn(
                      label: Center(child: Text('ID ATM', style: whiteTextStyle))),
                  DataColumn(
                      label: Center(child: Text('Merk Mesin', style: whiteTextStyle))),
                  DataColumn(
                      label: Center(child: Text('Type Mesin', style: whiteTextStyle))),
                  DataColumn(
                      label: Center(child: Text('Serial Number', style: whiteTextStyle))),
                  DataColumn(
                      label: Center(child: Text('Status', style: whiteTextStyle))),
                  DataColumn(
                      label: Center(child: Text('Detail', style: whiteTextStyle))),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Center(child: Text('1'))),
                    DataCell(Center(child: Text('A01'))),
                    DataCell(Center(child: Text('ATM01B'))),
                    DataCell(Center(child: Text('Wincor'))),
                    DataCell(Center(child: Text('Procash'))),
                    DataCell(Center(child: Text('Serial Number'))),
                    DataCell(Center(child: Text('Done'))),
                    DataCell(
                      Center(
                        child: ListTile(
                          leading: Icon(Icons.info),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                  DataRow(cells: [
                    DataCell(Center(child: Text('2'))),
                    DataCell(Center(child: Text('A01'))),
                    DataCell(Center(child: Text('ATM01B'))),
                    DataCell(Center(child: Text('Wincor'))),
                    DataCell(Center(child: Text('Procash'))),
                    DataCell(Center(child: Text('Serial Number'))),
                    DataCell(Center(child: Text('Done'))),
                    DataCell(
                      Center(
                        child: ListTile(
                          leading: Icon(Icons.info),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: CupertinoScrollbar(
              controller: _horizontalController,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _horizontalController,
                child: SizedBox(
                  width: 800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
