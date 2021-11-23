import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hamtarot_app/Form/View_form.dart';
import 'package:hamtarot_app/HomePage.dart';
import 'package:hamtarot_app/History/history_controllers.dart';
import 'package:hamtarot_app/History/history_model.dart';
import 'package:hamtarot_app/History/history_services.dart';
import 'package:hamtarot_app/Login/login.dart';
import 'package:hamtarot_app/Login/model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
            Consumer<Loginmodel>(builder: (context, form, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                    textTheme: TextTheme().apply(bodyColor: Colors.black),
                    dividerColor: Colors.white,
                    iconTheme: IconThemeData(color: Colors.white)),
                child: PopupMenuButton<int>(
                  color: Colors.black,
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text(form.email)),
                    // PopupMenuItem<int>(
                    //  value: 1, child: Text("Privacy Policy page")),
                    PopupMenuDivider(),
                    PopupMenuItem<int>(
                      value: 4,
                      child: Row(
                        children: [
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
                          Text("Home"),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 4,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => History_page(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.history)),
                          Text("Result History"),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 4,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisView(),
                                  ),
                                );
                              },
                              icon: Icon(Icons.schedule)),
                          Text("Booking History"),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 4,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await FirebaseAuth.instance.signOut().then(
                                    (value) => Navigator.of(context)
                                        .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) => Login()),
                                            (route) => false));
                              },
                              icon: Icon(Icons.logout)),
                          Text("Logout"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ]),
      body: ListView.separated(
        itemCount: history.isEmpty ? 1 : history.length,
        itemBuilder: (context, index) {
          if (history.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("ไม่พบข้อมูล"),
              ],
            );
          }

          return Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 5, left: 10),
                child: Row(
                  children: [Icon(Icons.feed_rounded)],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 5, left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('ผลคำทำนาย : ' + history[index].result),
                      Text('วันที่ : ' +
                          getTime(history[index].historydate).toString()),
                    ],
                  ),
                ),
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
    );
  }
}
