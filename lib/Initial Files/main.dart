import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter/material.dart";
import 'package:postgres/postgres.dart';
import 'package:true_link/Initial%20Files/LoginPage.dart';
import '../Activities/HomePage.dart';
import '../Data&Methods/Users.dart';
import '../Hidden Files/PrivateData.dart';
import 'Background.dart';
import 'ThemeInfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TrueLink());
}

class TrueLink extends StatefulWidget {
  const TrueLink({super.key});

  @override
  State<TrueLink> createState() => _TrueLinkState();
}

class _TrueLinkState extends State<TrueLink> {
  bool isLoading = true;
  bool isHome = false;

  @override
  void initState() {
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

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (await Users.getUserData()) {
          setState(() {
            isLoading = false;
            isHome = true;
          });
        } else {}
      } else {
        setState(() {
          isLoading = false;
          isHome = false;
        });
      }
    } catch (e) {}
  }

  void showSnackBar(BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        margin: const EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: ThemeInfo.gradientColor1,
          foregroundColor: ThemeInfo.themeColor,
          centerTitle: true,
        ),
      ),
      home: Scaffold(
        body: isLoading ?
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              const Background(),
              Center(
                child: Image.asset(
                  ThemeInfo.loadingIcon,
                  height: 100,
                  color: ThemeInfo.themeColor,
                ),
              ),
            ],
          ),
        ) :
        (isHome ?
        const HomePage() :
        const LoginPage()),
      )
    );
  }
}
