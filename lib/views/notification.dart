import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/utils.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({Key? key});

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
                        'Notification',
                        style: MyTextStyles.style8,
                      ),
                    ],
                  ),
                ),
          // Container Besar
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 640,
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    String status = index % 2 == 0 ? 'Done' : 'In Progress';
                    return CustomNotificationCard(index: index, status: status);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomNotificationCard extends StatelessWidget {
  final int index;
  final String status;

  const CustomNotificationCard({Key? key, required this.index, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.atm, color: Colors.green, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  'ID ATM: $index',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.confirmation_number, color: Colors.orange, size: 24),
                ),
                SizedBox(width: 12),
                Text(
                  'Nomor Tiket: XYZ-$index',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: status == 'Done' ? Colors.green : Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: NotifPage(),
    ),
  ));
}
