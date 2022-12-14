import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(125, 164, 83, 9.0),
          Color.fromRGBO(242, 238, 237, 0.0)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Turismo App',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            ImagenLogo(),
            SizedBox(
              height: 50.0,
            ),
            Icon(Icons.sync_outlined,
                size: 50.0,
                color: Color(
                  0xFF7DA453,
                ))
          ],
        )),
      ),
    );
  }

  Widget ImagenLogo() {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Image.asset(
        'assets/img/Logo.png',
        width: 350,
        height: 270,
      ),
    );
  }
}
