import 'package:flutter/material.dart';
import 'package:muistipeli/screen2.dart';

void main() => runApp(const MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late ImageProvider startPic;

  // ignore: non_constant_identifier_names
  final List<String> old_person = ["assets/old_lady_small.jpg", "assets/old_gentleman_small.jpg"];

  @override
  Widget build(BuildContext context) {

    int rndNum = DateTime.now().millisecondsSinceEpoch % 2;
    if (rndNum == 0) {
      startPic = AssetImage(old_person[0]);
    } else {
      startPic = AssetImage(old_person[1]);
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('Muistipeli'),
          backgroundColor: Colors.teal),
      body: Column(children: <Widget>[
          Image(image: startPic),
        Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Screen2()));
          },
          child: const Text('Pelaa sanamuistipeliä'),
        ),
      ),
    ])
  );
  }
}