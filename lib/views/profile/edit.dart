import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final userData = snapshot.data!;

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
                Positioned(
                  top: 200,
                  left: 20,
                  right: 20,
                  child: Container(
                    width: 327,
                    height: 500,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 80),
                        // Ini adalah input untuk mengedit username
                        TextField(
                          controller: TextEditingController(text: userData['username'] as String),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Ini adalah input untuk mengedit email
                        TextField(
                          controller: TextEditingController(text: userData['email'] as String),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1,
                          indent: 30,
                          endIndent: 30,
                        ),
                        // Ini adalah input untuk mengedit Nama Bank
                        ListTile(
                          leading: Icon(Icons.business),
                          title: Text('Nama Bank',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: TextField(
                            controller: TextEditingController(text: userData['bankname1'] as String),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Ini adalah input untuk mengedit Cabang
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text('Cabang',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: TextField(
                            controller: TextEditingController(text: userData['branchName'] as String),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        // Ini adalah input untuk mengedit Nomor HP
                        ListTile(
                          leading: Icon(Icons.call),
                          title: Text('Nomor Hp',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          subtitle: TextField(
                            controller: TextEditingController(text: userData['nohp'] as String),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  top: 140,
                  left: 125,
                  right: 125,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.orange,
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: AssetImage('assets/logo/foto.jpeg'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 20.0,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 90),
                      Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 0.07,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 150,
                  right: 150,
                  left: 150,
                  child: TextButton(
                    onPressed: () {
                      // Implementasikan logika untuk menyimpan perubahan ke server di sini
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Simpan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox(); 
        }
      },
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse('http://10.10.7.242:8134/emware-ws-sams/usman/login?user=mbl01&pass=259fa6a4c0d4dc0706fb46b47caabd5b153526ecd2df791b1d8d1dcbff13905e&appid=15&bankid=521'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic>) {
        final userData = data['data']['usermap'];
        final branchData = data['data']['branchmap'];
        final configData = data['data']['cfg_sys'];

        final String username = userData['usernm'].toString();
        final String email = userData['email'].toString();
        final String branchName = branchData['branchname'].toString();

        final String nohp = userData.containsKey('nohp') ? userData['nohp'].toString() : 'Tidak ada nomor telepon';

        final String bankname1 = configData['bankname1'].toString();

        return {
          'username': username,
          'email': email,
          'branchName': branchName,
          'nohp': nohp,
          'bankname1': bankname1,
        };
      } else {
        throw Exception('Data yang diterima dari API tidak sesuai dengan yang diharapkan');
      }
    } else {
      throw Exception('Gagal mengambil data: ${response.reasonPhrase}');
    }
  }
}
