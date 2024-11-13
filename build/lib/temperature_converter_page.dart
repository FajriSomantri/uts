import 'package:flutter/material.dart';

class TemperatureConverterPage extends StatefulWidget {
  @override
  _TemperatureConverterPageState createState() => _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  final TextEditingController _tempController = TextEditingController();
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double _convertedTemp = 0;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _convertTemperature() {
    final double temp = double.tryParse(_tempController.text) ?? 0;
    double result = 0;

    if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
      result = (temp * 9 / 5) + 32;
    } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
      result = (temp - 32) * 5 / 9;
    }

    setState(() {
      _convertedTemp = result;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hasil: $_convertedTemp $_toUnit')),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konversi Suhu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Suhu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            // Dropdown untuk memilih unit suhu
            DropdownButton<String>(
              value: _fromUnit,
              items: ['Celsius', 'Fahrenheit']
                  .map((unit) => DropdownMenuItem(
                        child: Text(unit),
                        value: unit,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _fromUnit = value!;
                });
              },
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _toUnit,
              items: ['Celsius', 'Fahrenheit']
                  .map((unit) => DropdownMenuItem(
                        child: Text(unit),
                        value: unit,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _toUnit = value!;
                });
              },
            ),
            SizedBox(height: 20),
            // DatePicker untuk memilih tanggal
            ListTile(
              title: Text(
                "Tanggal: ${_selectedDate.toLocal()}".split(' ')[0],
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 10),
            // TimePicker untuk memilih waktu
            ListTile(
              title: Text("Waktu: ${_selectedTime.format(context)}"),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Konversi Suhu'),
            ),
            SizedBox(height: 20),
            Text(
              'Suhu Terkonversi: $_convertedTemp $_toUnit',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
