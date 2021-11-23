import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hamtarot_app/HomePage.dart';
import 'package:hamtarot_app/Question/question_form_model.dart';
import 'package:hamtarot_app/Question/question_page.dart';
import 'package:hamtarot_app/Question/qcard_model.dart';

import 'package:provider/provider.dart';

class AnswerPage extends StatefulWidget {
  final Qcard newqcard;
  const AnswerPage({Key? key, required this.newqcard}) : super(key: key);

  @override
  _AnswerPageState createState() => _AnswerPageState();
}

class _AnswerPageState extends State<AnswerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ผลคำทำนาย'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ),
                );
              },
              icon: Icon(Icons.home)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Consumer<QuestionFormmodel>(
                builder: (context, form, child) {
                  return Text('ผลการทำนายของคุณ',
                      style: TextStyle(fontSize: 25));
                },
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(right: 20, left: 20),
                child: Column(
                  children: [
                    Text('${widget.newqcard.title}',
                        style: TextStyle(fontSize: 20)),
                    Image.network(
                      widget.newqcard.img,
                      width: 200,
                      height: 350,
                    ),
                    Consumer<QuestionFormmodel>(
                      builder: (context, form, child) {
                        return Text(
                            'จากคำถาม ${form.question}  ${widget.newqcard.content}');
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    //code resetform ตอนย้อนกลับ
                    Navigator.pushAndRemoveUntil<QuestionForm>(
                      //ชื่อคลาสฟอร์ม
                      context,
                      MaterialPageRoute<QuestionForm>(
                        builder: (BuildContext context) =>
                            QuestionPage(), //ชื่อคลาสเพจ
                      ),
                      (route) => false,
                    );
                  },
                  child: Text('ทำนายใหม่อีกครั้ง'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/9');
                  },
                  child: Text('ไหว้พระเสริมบุญ'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        child: CurvedNavigationBar(
          color: Color(0xFF6d4c41),
          backgroundColor: Color(0xFFFFF8E1),
          buttonBackgroundColor: Color(0xFF6d4c41),
          height: 50,
          items: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pop(context, '/3');
                },
                icon: Icon(Icons.crop_portrait, size: 30, color: Colors.black)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/4');
                },
                icon: Icon(Icons.amp_stories_rounded,
                    size: 30, color: Colors.black)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/5');
                },
                icon: Icon(Icons.quiz, size: 30, color: Colors.black)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/6');
                },
                icon:
                    Icon(Icons.battery_unknown, size: 30, color: Colors.black)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/2');
                },
                icon: Icon(Icons.date_range_rounded,
                    size: 30, color: Colors.black)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/9');
                },
                icon: Icon(Icons.account_balance_rounded,
                    size: 30, color: Colors.black)),
          ],
          index: 2,
        ),
      ),
    );
  }
}
