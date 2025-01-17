import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController _controller;

  late double deviceWidth;
  late double deviceHeight;

  int pic = 0;
  late int round;
  late double width;
  late double height;
  late List<int> instances = [];
  bool ask = false;
  bool congratulations = false;
  bool answered = false;
  bool again = false;
  int answer = 0;
  final List<int> originalNumbers = [0,1,2,3,4];

  final List<String> picture = ["assets/karkki.jpg", "assets/leipa.jpg", "assets/pilvi.jpg", "assets/putki.jpg", "assets/omena.jpg"];
  List<ImageProvider> image = [];

  List<String> questions = ["Monentenako KARKKI esiintyi?", "Monentenako LEIPÄ esiintyi?", "Monentenako PILVI esiintyi?", "Monentenako PUTKI esiintyi?", "Monentenako OMENA esiintyi?"];

  late ImageProvider _img;

  late double timeline;
  int rightAnswer = -1;
  late List<int> numbers;
  var rnd = Random();

  void preloadImages() {
    for (int i = 0; i < picture.length; i++) {
      image.add(AssetImage(picture[i]));  
    }
  }

  void resetGame() {
    setState(() {

      ask = false;
      answered = false;
      congratulations = false;
      timeline = 500;
      round = 0;
      again = true;

      pic = instances[0];
      pic = originalNumbers[pic];
      _img = image[pic];
    });
  }

  void checkAnswer(int a) {
    if (answered == true) return;

    answered = true;

    if (rightAnswer == a) {
      congratulations = true;
    } else {
      congratulations = false;
    }

  }

  @override
  void initState() {
    super.initState();

    preloadImages();

    instances = [];
    numbers = [0,1,2,3,4];

    // draw the first picture
    pic = rnd.nextInt(numbers.length);

    // draw what is the answer at the end for the question
    answer = rnd.nextInt(numbers.length);

    instances.add(pic);

    pic = numbers[pic];
    answer = numbers[answer];

    round = 0;
    timeline = 500;
    congratulations = false;
    answered = false;
    ask = false;

    // check if the first draw equals the right answer
    if (answer == pic) {
      rightAnswer = round;
    }

    numbers.removeWhere( (item) => item == pic );
    
    _img = image[pic];
    

    _controller = AnimationController(
      duration: const Duration(minutes: 10),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 9).animate(_controller);
    animation.addListener(() {
       setState(() {

          if (timeline > 0) timeline-=2;

          if (numbers.isEmpty && round == 4 && timeline == 0 && answered == false && ask == false) {
                ask = true;
          }

          if (ask == false) {
           

            if (timeline == 0) {
                  round++;

                  rnd = Random.secure();
                  if (again == false) {
                    pic = rnd.nextInt(numbers.length);
                    pic = numbers[pic];
                    instances.add(pic);
                    numbers.removeWhere( (item) => item == pic );
                  } else {
                    pic = instances[round];
                    pic = originalNumbers[pic];
                  }

                  if (pic == answer) {
                    rightAnswer = round;
                  }

                  timeline = 500;
                  _img = image[pic];
                
              }
          }
    });
    
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

        deviceWidth = MediaQuery.sizeOf(context).shortestSide;
        deviceHeight = MediaQuery.sizeOf(context).longestSide;

        const spacer = Padding(padding: EdgeInsets.all(4));
        const spacerBig = Padding(padding: EdgeInsets.all(8));

        return Scaffold(appBar: AppBar(
          title: const Text('Sanamuistipeli'),
          backgroundColor: Colors.teal),
          
          body:

          Center(child: Column(children: <Widget>[
          
          if (!ask) Center(child:  Image(width: deviceWidth, height: deviceHeight * 0.2, image: _img)),
          
          SizedBox(child:
          Container(
          width: timeline,
          height: deviceHeight * 0.025,
          decoration: BoxDecoration(
            color: Colors.blue[900],
          ))),

          if (ask) Column(children: [        
          Text(questions[answer]),
          spacer,
          ElevatedButton(onPressed: () => checkAnswer(0), child: const Text("1")),
          spacer,
          ElevatedButton(onPressed: () => checkAnswer(1), child: const Text("2")),
          spacer,
          ElevatedButton(onPressed: () => checkAnswer(2), child: const Text("3")),
          spacer,
          ElevatedButton(onPressed: () => checkAnswer(3), child: const Text("4")),
          spacer,
          ElevatedButton(onPressed: () => checkAnswer(4), child: const Text("5"))
          ]),
          if (congratulations == true && answered == true) Column(children: <Widget>[
            const Text("MAHTAVAA! OIKEIN!", style: TextStyle(fontSize: 18.0, color: Colors.green),),
            ElevatedButton(onPressed: () => {Navigator.pushReplacement(context,MaterialPageRoute(
            builder: (BuildContext context) => super.widget))} , child: const Text("Pelaa uusi peli"))]),
          if (congratulations == false && answered == true) const Column(children: [
            Text("Valitetavasti meni väärin."),
            Text("Alla näet, missä järjestyksessä sanakuvat ilmestyivät.")
          ]),
          if (congratulations == false && answered == true) Column(children: [
            spacerBig,
            Image(width: deviceWidth * 0.18, image: image[instances[0]]),
            spacerBig,
            Image(width: deviceWidth * 0.18, image: image[instances[1]]),
            spacerBig,
            Image(width: deviceWidth * 0.18, image: image[instances[2]]),
            spacerBig,
            Image(width: deviceWidth * 0.18, image: image[instances[3]]),
            spacerBig,
            Image(width: deviceWidth * 0.18, image: image[instances[4]]),
            spacerBig,
              ElevatedButton(onPressed: () => resetGame(), child: const Text("Yritä uudelleen samaa tehtävää")),
              spacer,
              ElevatedButton(onPressed: () => {congratulations = false, ask = false, answered = false, Navigator.pushReplacement(context,MaterialPageRoute(
            builder: (BuildContext context) => super.widget))}, child: const Text("Pelaa uusi peli"))
          ]),
          ])));
  
  }
}
