import 'package:flutter/material.dart';

import '../Activities/HomePage.dart';
import '../Data&Methods/Users.dart';
import 'Background.dart';
import 'ThemeInfo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Positioned(
            bottom: 60,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                if (await Users.createUser()) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()),);
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 60,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: ThemeInfo.gradientColor1,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: ThemeInfo.themeColor,
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeInfo.themeColor.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: isLoading ?
                Center(
                  child: Image.asset(
                    ThemeInfo.loadingIcon,
                    height: 100,
                    color: ThemeInfo.themeColor,
                  ),
                ) :
                Center(
                  child: Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: ThemeInfo.themeColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
