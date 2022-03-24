import 'package:flutter/material.dart';
import 'package:social_manager/utils/store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) {
      Navigator.of(context)
          .pushReplacementNamed(Store.user == null ? 'auth' : 'home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Color(0xffE3E3BB),
      ),
      child: Image(
        image: AssetImage('assets/images/logo.png'),
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
