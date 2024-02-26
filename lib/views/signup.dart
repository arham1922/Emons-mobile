import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: -50,
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
                ]
                ),
                );
                }
                }