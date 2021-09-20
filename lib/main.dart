import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double? x;
  double? y;
  bool? count;
  List<AnimatedAlign> circlesList = [];

  void doubleInRange(num start, num end) {
    setState(() {
      x = Random().nextDouble() * (end - start) + start;
      y = Random().nextDouble() * (end - start) + start;
    });
  }

  List<AnimatedAlign> getCircles() {
    for (int i = 0; i < 10; i++) {
      doubleInRange(-1, 1);
      circlesList.add(
        AnimatedAlign(
          alignment: Alignment(x!, y!),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
          ),
        ),
      );
    }
    return circlesList;
  }

  void addCircle() {
    circlesList.add(
      AnimatedAlign(
        alignment: Alignment(x!, y!),
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  void updateCircles() {
    if (count == true) {
      for (int i = 0; i < circlesList.length; i++) {
        doubleInRange(-1, 1);
        circlesList[i] = AnimatedAlign(
          onEnd: () {
            updateCircles();
          },
          alignment: Alignment(x!, y!),
          duration: Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCircles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: circlesList,
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                count = true;
                addCircle();
                updateCircles();
              },
              child: Text('Animate'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count = false;
                });
              },
              child: Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
