import 'package:first_app/SecondPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/first_from_model.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  //String? _formData = 'ได้โปรดไปกรอกที่หน้าอื่น';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page First Page'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
          IconButton(onPressed: () {}, icon: Icon(Icons.agriculture)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(),
                  ),
                );
              },
              icon: Icon(Icons.bus_alert)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/3');
              },
              icon: Icon(Icons.medication)),
          //IconButton(onPressed: () {}, icon: Icon(Icons.bus_alert)),
          //IconButton(onPressed: () {}, icon: Icon(Icons.medication)),
          IconButton(onPressed: () {}, icon: Icon(Icons.food_bank)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Consumer<FirstFormModel>(
                builder: (context, form, child) {
                  return Text('${form.firstName} ${form.lastName} ${form.age}');
                },
              ),
            ),
            /* padding: EdgeInsets.all(20.0),
              child: Text('$_formData'),
            ),
            ElevatedButton(
              onPressed: () async {
                var response = await Navigator.pushNamed(context, '/6');

                if (response != null && !response.toString().isEmpty) {
                  setState(() {
                    _formData = response.toString();
                  });
                }
              },*/
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/6');
              },
              child: Text('คลิกปุ่มนี้ Fill this form please'),
            ),
          ],
        ),
      ),
    );
  }
}
