import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();
  String _operation = '+';
  double _result = 0;
  bool _isAdvancedMode = false;

  void _calculate() {
    final double num1 = double.tryParse(_num1Controller.text) ?? 0;
    final double num2 = double.tryParse(_num2Controller.text) ?? 0;

    setState(() {
      switch (_operation) {
        case '+':
          _result = num1 + num2;
          break;
        case '-':
          _result = num1 - num2;
          break;
        case '*':
          _result = num1 * num2;
          break;
        case '/':
          _result = num2 != 0 ? num1 / num2 : double.infinity;
          break;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hasil: $_result')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Angka 1',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Angka 2',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Radio button untuk memilih operasi
            Text('Pilih Operasi:'),
            Row(
              children: [
                Radio(
                  value: '+',
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value.toString();
                    });
                  },
                ),
                Text('+'),
                Radio(
                  value: '-',
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value.toString();
                    });
                  },
                ),
                Text('-'),
                Radio(
                  value: '*',
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value.toString();
                    });
                  },
                ),
                Text('*'),
                Radio(
                  value: '/',
                  groupValue: _operation,
                  onChanged: (value) {
                    setState(() {
                      _operation = value.toString();
                    });
                  },
                ),
                Text('/'),
              ],
            ),
            SizedBox(height: 20),
            // Checkbox untuk memilih mode kalkulator
            Row(
              children: [
                Checkbox(
                  value: _isAdvancedMode,
                  onChanged: (value) {
                    setState(() {
                      _isAdvancedMode = value ?? false;
                    });
                  },
                ),
                Text("Mode Lanjutan"),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Hitung'),
            ),
            SizedBox(height: 20),
            Text(
              'Hasil: $_result',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
