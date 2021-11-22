import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hamtarot_app/HomePage.dart';
import 'package:hamtarot_app/Login/model.dart';
import 'package:hamtarot_app/Question/answer_page.dart';
import 'package:hamtarot_app/Question/question_form_model.dart';
import 'package:hamtarot_app/Question/qcard_controller.dart';
import 'package:hamtarot_app/Question/qcard_model.dart';
import 'package:hamtarot_app/Question/qcard_services.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ไพ่ทายคำ'),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/card_back.png', width: 200, height: 300),
            Text(
              'ให้ไพ่ช่วยทำนายกัน',
              style: TextStyle(fontSize: 25, color: Colors.black54),
            ),
            QuestionForm(),
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
                  Navigator.pushNamed(context, '/3');
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

class QuestionForm extends StatefulWidget {
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formKey = GlobalKey<FormState>();
  String? _question;
  String? _name;
  Services? service;
  QcardController? controller;
  List<Qcard> qcard = List.empty();
  int randomIndex = Random().nextInt(22);

  @override
  void initState() {
    super.initState();

    service = QcardServices();
    controller = QcardController(service!);
  }

  void getQcard() async {
    var newqcard = await controller!.fectQcard();

    setState(() {
      qcard = newqcard;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'ชื่อของคุณ',
              icon: Icon(Icons.person_pin_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณาใส่ชื่อของคุณ';
              }
              return null;
            },
            onSaved: (value) {
              _name = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'โปรดพิมพ์คำถามของคุณ',
              icon: Icon(Icons.question_answer_rounded),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'เอ๊ะ ลืมใส่คำถามหรือเปล่านะ?';
              }
              return null;
            },
            onSaved: (value) {
              _question = value;
            },
          ),
          ElevatedButton(
            onPressed: () async {
              getQcard();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                context.read<QuestionFormmodel>().name = _name;
                context.read<QuestionFormmodel>().question = _question;

                await Future.delayed(const Duration(milliseconds: 1500));

                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Qcard newqcard = qcard[randomIndex];
                    return AlertDialog(
                      content: Text('คุณได้ไพ่ ${newqcard.title}'),
                      contentPadding: EdgeInsets.all(30),
                      actions: <Widget>[
                        Consumer<Loginmodel>(
                          builder: (context, form, child) {
                            return ElevatedButton(
                                onPressed: () async {
                                  String cardname = 'คุณได้ไพ่ ';
                                  await FirebaseFirestore.instance
                                      .collection('ham_history')
                                      .add({
                                    'email': form.email,
                                    'result': '$cardname' + '${newqcard.title}',
                                    'historydate': Timestamp.now(),
                                  });
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AnswerPage(newqcard: newqcard),
                                      ));
                                },
                                child: Center(child: Text('ดูคำทำนาย')));
                          },
                        ),
                      ],
                    );
                  },
                );
              } else
                () {
                  setState(() {});
                };
            },
            child: Text('ทำนาย'),
          ),
        ],
      ),
    );
  }
}
