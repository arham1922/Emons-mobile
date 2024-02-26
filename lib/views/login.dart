// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/homepage.dart';
import 'package:flutter_application_1/views/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String baseUrl = '10.10.7.241:10521/emware-ws-sams/';
  bool _isObscure = true;
  String errorMessage = '';

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final encryptedPassword = MD5AndSHA256encrypt(password);
    print('encryptedPassword = ' + encryptedPassword);
    print('Password: $password');
    final response = await http.get(
      Uri.parse('$baseUrl?user=$username&pass=$encryptedPassword&appid=15&bankid=521'),
    );
    print('Response: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      String rcode = responseData['rcode'].toString();
      print('rcode = $rcode');
      if (rcode == '00') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Failed'),
            content: Text('Username or password is incorrect.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Network Error'),
          content: Text('Failed to connect to the server.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  String MD5encrypt(String password) {
    var MD5Pass = md5.convert(utf8.encode(password)).toString().toUpperCase();

    return MD5Pass;
  }

  String MD5AndSHA256encrypt(String password) {
    var MD5Pass = md5.convert(utf8.encode(password)).toString().toUpperCase();
    var sha256Pass = sha256.convert(utf8.encode(MD5Pass)).toString();
    print('sha256 =' + sha256Pass);
    print('md5 =' + MD5Pass);
    return sha256Pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: -100,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 370,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo/decoration1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 43,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF747980),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 43,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xFF747980),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Image.asset(
                            _isObscure ? 'assets/icon/show.png' : 'assets/icon/hidden.png',
                            width: 24,
                            height: 24,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFFFF0000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      fixedSize: const Size(342, 40),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ? ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff939393),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                          },
                          child: const Text(
                            'Sign-up',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFFA913B),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16.0,
            top: 250.0,
            child: Text(
              'Login',
              style: TextStyle(
                color: Color(0xFFFA913B),
                fontSize: 28,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w800,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
