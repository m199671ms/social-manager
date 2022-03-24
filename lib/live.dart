// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_manager/utils/api_handler.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Material App Bar'),
            ),
            body: Center(
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    bool created = await ApiHandler.addMediaService(
                      icon: FontAwesomeIcons.instagram,
                      name: {
                        'en': "Instagram",
                        'ar': 'انستغرام',
                      },
                      domain: 'instagram',
                      homePage: Uri.parse('https://www.instagram.com/'),
                      iconColor: const Color(0xff405DE6),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Created $created'),
                      ),
                    );
                  },
                  child: const Text('Add Icon To Server'),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
