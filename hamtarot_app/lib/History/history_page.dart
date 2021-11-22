import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hamtarot_app/HomePage.dart';
import 'package:hamtarot_app/History/history_controllers.dart';
import 'package:hamtarot_app/History/history_model.dart';
import 'package:hamtarot_app/History/history_services.dart';
import 'package:intl/intl.dart';

String getTime(var time) {
  final DateFormat formatter =
      DateFormat('dd/MM/yyyy, hh:mm aa'); //your date format here
  var date = time.toDate();
  return formatter.format(date);
}

class History_page extends StatefulWidget {
  @override
  _History_pageState createState() => _History_pageState();
}

class _History_pageState extends State<History_page> {
  Services? service;
  HistoryController? controller;
  List<History> history = List.empty();
  bool isloading = false;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    service = HistoryServices();
    controller = HistoryController(service!);
    // controller!.onSync
    //     .listen((bool synState) => setState(() => isLoading = synState));
    getHistory();
  }

  void getHistory() async {
    var newhistory = await controller!.fecthistory(user!.email);

    setState(() {
      history = newhistory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Your History'),
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
          ]),
      body: ListView.separated(
        itemCount: history.isEmpty ? 1 : history.length,
        itemBuilder: (context, index) {
          if (history.isEmpty) {
            return Text("ไม่พบข้อมูล");
          }

          return Row(
            children: [
              Row(
                children: [Icon(Icons.date_range_rounded)],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Icon(Icons.ac_unit),
                  Text("ผลคำทำนาย : " + history[index].result),
                  Text("วันที่ : " +
                      getTime(history[index].historydate).toString()),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
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
          //  animationDuration: Duration(milliseconds: 200),
          index: 5,
        ),
      ),
    );
  }
}
