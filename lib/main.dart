import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Muistipeli'),
          backgroundColor: Colors.teal),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Screen2()));
          },
          child: const Text('GO TO SCREEN 2'),
        ),
      ),
    );
  }
}
class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text('Sanamuistipeli - alkuruutuun napsauttamalla reunassa'),
          backgroundColor: Colors.blueAccent),
      body: Column(children: <Widget>[const Center(child: Image(image: AssetImage('assets/karkki.png')),),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(builder: (context)=>const Home()));

          },
          child: const Text('GO TO HOME'),
      ),
    ]),
    );
  }
}