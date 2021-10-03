import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:midterm_app/HomePage.dart';
import 'package:midterm_app/Page/Card_1.dart';
import 'package:midterm_app/Page/Card_3.dart';
import 'package:midterm_app/Page/Form.dart';
import 'package:midterm_app/Page/Question.dart';
import 'package:midterm_app/Page/Siamese.dart';
import 'package:midterm_app/Page/form_show.dart';
import 'package:midterm_app/model/DataFormModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataFormModel(),
        )
      ],
      child: MyAppHamtarot(),
    ),
  );
}

class MyAppHamtarot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //title: 'Hamtarot',
        theme: ThemeData(
          primaryColor: Colors.brown[600],
          accentColor: Colors.red,
          scaffoldBackgroundColor: const Color(0xFFFFF8E1),
          textTheme: GoogleFonts.promptTextTheme(
            Theme.of(context).textTheme,
          ),
        ),

        //home: MyHomePage(title: 'Kritsada 6302037145'),
        initialRoute: '/1',
        routes: <String, WidgetBuilder>{
          '/1': (context) => MyHomePage(),
          '/2': (context) => FormPage(), //form
          '/3': (context) => Showdata(),
          '/4': (context) => Card1(),
          '/5': (context) => Card3(),
          '/6': (context) => question(),
          '/7': (context) => siamese(),
        });
  }
}
