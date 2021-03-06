import 'package:flutter/material.dart';

import 'model/first_from_model.dart';
import 'package:provider/provider.dart';

class sixthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Form six page'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your firstname',
              icon: Icon(Icons.business),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter firstname';
              }
              return null;
            },
            onSaved: (value) {
              _firstName = value;
            },
            initialValue: context.read<FirstFormModel>().firstName,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your lastname',
              icon: Icon(Icons.family_restroom),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter lastname';
              }
              return null;
            },
            onSaved: (value) {
              _lastName = value;
            },
            initialValue: context.read<FirstFormModel>().lastName,
          ),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your age',
              icon: Icon(Icons.ring_volume),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter age';
              }

              if (int.parse(value) < 18) {
                return 'Please enter valid age';
              }
              return null;
            },
            onSaved: (value) {
              _age = int.parse(value!);
            },
            initialValue: context.read<FirstFormModel>().age.toString(),
          ),

          /* ElevatedButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('?????????????????????????????????')),
              );*/
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                //ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     content: Text('Hoorayyyy = $_firstName $_lastName $_age'),
                //                ));
                // var response = 'Hoorayyyy = $_firstName $_lastName $_age';
                // Navigator.pop(context, response);
                context.read<FirstFormModel>().firstName = _firstName;
                context.read<FirstFormModel>().lastName = _lastName;
                context.read<FirstFormModel>().age = _age;
                Navigator.pop(context);
              }
            },
            child: const Text('validate'),
          ),
        ],
      ),
    );
  }
}
