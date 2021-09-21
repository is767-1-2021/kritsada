import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teamp_app/test/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:teamp_app/test/email_validator.dart';

class FormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จองคิวพบหมอโหรา'),
      ),
      body: MyCustomForm(),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
          inputDecorationTheme:
              InputDecorationTheme(border: OutlineInputBorder())),
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('es'), // Spanish
        const Locale('fr'), // French
        const Locale('zh'), // Chinese
      ],
    );
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      /*TextFormField(
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'วันเวลาที่ต้องการนัดหมาย',
          icon: Icon(Icons.access_time),
        ),
*/
      Row(children: [
        //Icon(Icons.access_time),
        Text('วันเวลาที่ต้องการนัดหมาย'),
      ]),
      // Text('วันเวลาที่ต้องการนัดหมาย'),

      DateTimeField(
          //resetIcon: Icon(Icons.access_time),
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2100));

            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                builder: (context, child) => MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child!),
              );
              return DateTimeField.combine(date, time);
            } else {
              //return currentValue;
              return currentValue;
            }
          }),
    ]);
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final format2 = DateFormat("yyyy-MM-dd HH:mm");
  String? _firstName;
  String? _telnum;
  String? _mail;
  DateTime? value;
  DateTime? _resdate;
  //String? _mail1;
  //DateTime _dateTime;
  //final DateTime initialDateTime;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //Text('ชื่อ-นามสกุล1'),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'ชื่อ-นามสกุล',
              icon: Icon(Icons.people),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณาระบุชื่อ-นามสกุล';
              }
              return null;
            },
            onSaved: (value) {
              _firstName = value;
            },
          ),
          //Text('เบอร์โทรศัพท์1'),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'เบอร์โทรศัพท์',
              icon: Icon(Icons.phone),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณาระบุเบอร์โทรศัพท์';
              }
              return null;
            },
            onSaved: (value) {
              _telnum = value;
            },
          ),
          //Text('E-mail1'),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'E-mail',
              icon: Icon(Icons.email),
              // hintStyle: TextStyle(color: Colors.black45),
              // errorStyle: TextStyle(color: Colors.redAccent),
              //border: OutlineInputBorder(),
              // prefixIcon: Icon(Icons.event_note),
              // Icon: Icon(Icons.event_note),
              //border: UnderlineInputBorder(),
              //labelText: 'E-mail',
              // icon: Icon(Icons.email),
            ),
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'E-mail ไม่ถูกต้อง'
                    : null,

            /*validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณาระบุ E-mail';
              }
              return null;
            },*/
            onSaved: (value) {
              _mail = value;
            },
          ),
          /*TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'วันเวลาที่ต้องการนัดหมาย',
              icon: Icon(Icons.access_time),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'กรุณาระบุวันเวลาที่ต้องการนัดหมาย';
              }
              return null;
            },
            onSaved: (value) {
              _resdate = value;
            },
          ),*/
          //BasicDateTimeField(),
          //Text('วันเวลาที่ต้องการนัดหมาย'),

          //Icon(Icons.access_time),
          DateTimeField(
            decoration: const InputDecoration(
              //hintStyle: TextStyle(color: Colors.black45),
              //errorStyle: TextStyle(color: Colors.redAccent),
              //border: OutlineInputBorder(),
              // labelText: 'เลือกวันเวลา',
              // prefixIcon: Icon(Icons.event_note),
              border: UnderlineInputBorder(),
              labelText: 'เลือกวันเวลา',
              icon: Icon(Icons.event_note),
              //suffixIcon: Icon(Icons.event_note),
            ),
            //resetIcon: Icon(Icons.access_time),
            format: format2,

            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));

              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  builder: (context, child) => MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!),
                );
                //_resdate = DateTimeField.combine(date, time);
                return DateTimeField.combine(date, time);
              } else {
                //return currentValue;
                return currentValue;
              }
              //_resdate = date,
            },

            validator: (value) {
              if (value == null) {
                return 'กรุณาระบุ วันเวลาที่ต้องการ';
              }
              return null;
            },
            // onChanged: (value) {},

            onSaved: (value) => _resdate = value,
          ),

          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'จองบัตรคิว = $_firstName $_telnum $_mail $_resdate'),
                      ));
                      //var response = 'Hoorayyyy = $_firstName $_lastName $_age';
                      //Navigator.pop(context, response);
                    }
                  },
                  child: const Text('ลงทะเบียน'),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('จะลบใช่มั้ย'),
                            content: Text('ข้อมูลที่คุณกรอกจะโดนลบ'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  _formKey.currentState!.reset();
                                  Navigator.pop(context);
                                },
                                child: Text('ล้างข้อมูล'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('ยกเลิก'),
                              ),
                            ],
                          );
                        });
                  },
                  child: Text('ล้างข้อมูล'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
