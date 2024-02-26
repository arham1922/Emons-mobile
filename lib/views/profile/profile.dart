import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Map<String, dynamic> userData;
  late AssetImage backgroundImage;

  @override
  void initState() {
    super.initState();
    backgroundImage = AssetImage('assets/icon/user2.jpg');
  }

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
          userData = snapshot.data!;
          return buildProfilePage(context);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Scaffold buildProfilePage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo/BackgroundHeader1.png'),
                fit: BoxFit.cover,
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
                  Text(
                    userData['username'] as String,
                    style: MyTextStyles.style13,
                  ),
                  Text(
                    userData['email'] as String,
                    style: MyTextStyles.style14,
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 30,
                    endIndent: 30,
                  ),
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text('Nama Bank', style: MyTextStyles.style3),
                    subtitle: Text(userData['bankname1'] as String, style: MyTextStyles.style14),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Cabang', style: MyTextStyles.style3),
                    subtitle: Text(userData['branchName'] as String, style: MyTextStyles.style14),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Alamat', style: MyTextStyles.style3),
                    subtitle: Text(userData['address'] as String, style: MyTextStyles.style14),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('Kota', style: MyTextStyles.style3),
                    subtitle: Text(userData['city'] as String, style: MyTextStyles.style14),
                  ),
                  ListTile(
                    leading: Icon(Icons.call),
                    title: Text('Nomor Hp', style: MyTextStyles.style3),
                    subtitle: Text(userData['nohp'] as String, style: MyTextStyles.style14),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
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
                    backgroundImage: backgroundImage,
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: CircleAvatar(
                //     backgroundColor: Colors.orange,
                //     radius: 20.0,
                //     child: IconButton(
                //       icon: Icon(
                //         Icons.camera_alt,
                //         color: Colors.white,
                //       ), onPressed: () {  },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 90),
                Text(
                  'Profile',
                  style: MyTextStyles.style8,
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 50,
          //   right: 150,
          //   left: 150,
          //   child: TextButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => const EditProfilePage()),
          //       );
          //     },
          //     style: TextButton.styleFrom(
          //       backgroundColor: Colors.orange,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8.0),
          //       ),
          //     ),
          //     child: const Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Text(
          //           'Edit',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 16,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
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
        final String address = branchData['address'].toString();
        final String city = branchData['city'].toString();
        final String nohp = userData.containsKey('nohp') ? userData['nohp'].toString() : 'Tidak ada nomor telepon';
        final String bankname1 = configData['bankname1'].toString();

        return {
          'username': username,
          'email': email,
          'branchName': branchName,
          'nohp': nohp,
          'bankname1': bankname1,
          'address': address,
          'city': city,
        };
      } else {
        throw Exception('Data yang diterima dari API tidak sesuai dengan yang diharapkan');
      }
    } else {
      throw Exception('Gagal mengambil data: ${response.reasonPhrase}');
    }
  }
}
