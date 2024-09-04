import "package:flutter/material.dart";
import 'package:postgres/postgres.dart';
import 'package:true_link/UI/ThemeColors.dart';

import 'Activities/HomePage/HomePage.dart';
import 'Data&Methods/Users.dart';
import 'Hidden Files/PrivateData.dart';
import 'UI/Background.dart';

void main() {
  runApp(const TrueLink());
}

class TrueLink extends StatefulWidget {
  const TrueLink({super.key});

  @override
  State<TrueLink> createState() => _TrueLinkState();
}

class _TrueLinkState extends State<TrueLink> {
  bool isLoading = true;

  @override
  initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var uri = Uri.parse(PrivateData.connectionString);
      PrivateData.conn = await Connection.open(Endpoint(
        host: uri.host,
        database: uri.path.substring(1),
        username: uri.userInfo.split(':').first,
        password: uri.userInfo.split(':').last,
      ));
      if(await Users.getUserData(14)) {
        setState(() {
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Unable to block user!!!',
            ),
            backgroundColor: ThemeColors.gradientColor1.withOpacity(0.9),
            margin: const EdgeInsets.all(10),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load data!'),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeColors.gradientColor1,
          foregroundColor: ThemeColors.themeColor,
          centerTitle: true,
        ),
      ),
      home: isLoading ?
      SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            const Background(),
            Center(
              child: CircularProgressIndicator(
                color: ThemeColors.themeColor,
              ),
            ),
          ],
        ),
      ) :
      const HomePage(),
    );
  }
}