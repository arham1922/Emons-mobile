import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/utils.dart';

class HardwareStatusDDC extends StatelessWidget {
  const HardwareStatusDDC ({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> column1Data = [
      "Journal Printer",
      "Cash Reader",
      "Receipt Printer",
      "Depository",
      "Cassete 1",
      "Cassete 2",
      "Cassete 3",
      "Cassete 4",
    ];

    List<String> column2Data =  [
      "ENABLED",
      "ENABLED",
      "DISABLED",
      "LOW",
      "CASSETTE ID=A SUPPLAY LOW",
      "CASSETTE ID=A SUPPLAY LOW",
      "CASSETTE ID=A SUPPLAY LOW",
      "CASSETTE ID=A SUPPLAY LOW",
    ];
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
                  'Hardware Status',
                  style: MyTextStyles.style8,
                ),
              ],
            ),
          ),
          // Container Besar
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
            child: TwoColumnTable(column1: column1Data, column2: column2Data),
          ),
        ],
      ),
    );    
  }
}
