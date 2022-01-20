import 'package:flutter/material.dart';
import 'package:mychat/allConstants/constants.dart';
import 'package:mychat/allProvider/auth_provider.dart';
import 'package:mychat/allScreens/home_page.dart';
import 'package:mychat/allScreens/login_page.dart';
import 'package:provider/src/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      chekSignedIn();
    });
  }

  void chekSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/splash.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Dunyo Bo'yicha Shaxsiy Yozishuflar Ilovasi",
              style: TextStyle(color: ColorConstants.themeColor),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 20,
              height: 20,
              child: const CircularProgressIndicator(color: ColorConstants.themeColor,),
            ),
          ],
        ),
      ),
    );
  }
}
