import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_app/calculator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorProvider with ChangeNotifier {
  String equation = '';
  String result = '';

  void addToEquation(String sign, bool canFirst, BuildContext context) {
    if (equation == '') {
      if (sign == '.') {
        equation = '0.';
      } else if (canFirst) {
        equation = sign;
      }
    } else {
      if (sign == "CE") {
        equation = '';
        result = '';
      } else if (sign == "⌫") {
        if (equation.endsWith(' ')) {
          equation = '${equation.substring(0, equation.length - 3)}';
        } else {
          equation = '${equation.substring(0, equation.length - 1)}';
        }
      } else if (equation.endsWith('.') && sign == '.') {
        return;
      } else if (equation.endsWith(' ') && sign == '.') {
        equation = equation + '0.';
      } else if (equation.endsWith(' ') && canFirst == false) {
        equation = '${equation.substring(0, equation.length - 3) + sign}';
      } else if (sign == '=') {
        showToast(context, 'Saved');

        FirebaseFirestore.instance
            .collection('History')
            .add({'historyCal': equation + ' =', 'historyResult': result});
      } else {
        equation = equation + sign;
      }
    }
    if (equation == '0') {
      equation = '';
    }
    try {
      var privateResult = equation.replaceAll('÷', '/').replaceAll('×', '*');
      Parser p = Parser();
      Expression exp = p.parse(privateResult);
      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
    } catch (e) {
      result = '';
    }
    notifyListeners();
  }
}
