import 'package:flutter/material.dart';

import 'package:first_app/FirstPage.dart';
import 'package:first_app/SecondPage.dart';
import 'package:first_app/ThirdPage.dart';
import 'package:first_app/FourthPage.dart';
import 'package:first_app/FifthPage.dart';
import 'package:first_app/sixthPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.amber,
          accentColor: Colors.red,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.purple),
          ),
        ),
        // home: MyHomePage(title: 'Kritsada 6302037145'),
        initialRoute: '/5',
        routes: <String, WidgetBuilder>{
          '/1': (context) => FirstPage(),
          '/2': (context) => SecondPage(),
          '/3': (context) => ThirdPage(),
          '/4': (context) => FourthPage(),
          '/5': (context) => FifthPage(),
          '/6': (context) => sixthPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Image cat = Image.asset(
    'assets/popcat1.png',
    width: 120,
  );

  Image cat1 = Image.asset(
    'assets/popcat2.png',
    width: 120,
  );

  Image cat2 = Image.asset(
    'assets/popcat1.png',
    width: 120,
  );

  void _incrementCounter() {
    setState(() {
      cat = cat2;
      _counter++;
    });
  }

  void _decreaseCounter() {
    setState(() {
      cat = cat1;
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 100.0, right: 100.0, bottom: 20.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.35),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: cat,
            ),
            // cat,
            Text(
              'ถ้าคุณกดเพิ่ม ปากมันจะอ้า ถ้าคุณกดลง ปากก็จะหุบ',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: _decreaseCounter,
                  child: Text('Decrease'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: _incrementCounter,
                  child: Text('Increase'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String buttonText;
  SubmitButton(this.buttonText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(this.buttonText),
      onPressed: () {},
    );
  }
}
