import 'package:flutter/material.dart';
import 'package:teamp_app/Form.dart';
import 'package:teamp_app/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'หมอโหรา',
        theme: ThemeData(
          primaryColor: Colors.amber,
          //accentColor: Colors.red,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.purple),
          ),
        ),
        // home: MyHomePage(title: 'Kritsada 6302037145'),
        initialRoute: '/1',
        routes: <String, WidgetBuilder>{
          '/1': (context) => HomePage(),
          //'/2': (context) => CalendarPage(),
          '/3': (context) => FormPage(),
          //'/4': (context) => MyApp3(),
          '/5': (context) => MaterialApp(),
          //'/6': (context) => sixthPage(),
          //'/7': (context) => SeventhPage(),
        });
  }
}
