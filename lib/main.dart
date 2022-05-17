import 'package:base64decoding/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Base64 String',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FilePickerDemo(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => MyHomePageState();
}

class MyHomePageState extends State {
  late String _base64 = "";

  @override
  void initState() {
    super.initState();
    (() async {
      http.Response response = await http.get(
        Uri.parse(
            "https://wallpaper-house.com/data/out/9/wallpaper2you_366962.jpg"),
      );
      if (mounted) {
        setState(() {
          _base64 = const Base64Encoder().convert(response.bodyBytes);
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    if (_base64.isEmpty) return Container();
    Uint8List bytes = const Base64Codec().decode(_base64);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Base64 String'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            child: Image.memory(
          bytes,
          fit: BoxFit.cover,
        )),
      )),
    );
  }
}
