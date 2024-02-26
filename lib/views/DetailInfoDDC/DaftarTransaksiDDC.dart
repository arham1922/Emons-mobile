import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/utils.dart';

class DaftarTransaksiDDC extends StatelessWidget {
  const DaftarTransaksiDDC ({super.key});

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
                  'Daftar Transaksi',
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
        ],
      ),
    );    
  }
}