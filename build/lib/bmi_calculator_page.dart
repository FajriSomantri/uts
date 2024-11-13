import 'package:flutter/material.dart';

class BMICalculatorPage extends StatefulWidget {
  @override
  _BMICalculatorPageState createState() => _BMICalculatorPageState();
}

class _BMICalculatorPageState extends State<BMICalculatorPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double _bmi = 0;
  String _category = '';
  String _gender = '';
  bool _isActive = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _calculateBMI() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
        _category = _getBMICategory(_bmi);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('BMI Anda: $_bmi, Kategori: $_category'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan tinggi dan berat badan yang valid')),
      );
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Kurus';
    if (bmi < 24.9) return 'Normal';
    if (bmi < 29.9) return 'Kelebihan Berat Badan';
    return 'Obesitas';
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
        title: Text('Kalkulator BMI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Input Tinggi Badan
            TextFormField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: 'Tinggi Badan (cm)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            
            // Input Berat Badan
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Berat Badan (kg)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            
            // Pilih Gender dengan Radio Button
            Text("Pilih Gender:"),
            Row(
              children: [
                Radio(
                  value: 'Laki-Laki',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value.toString();
                    });
                  },
                ),
                Text("Laki-Laki"),
                Radio(
                  value: 'Perempuan',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value.toString();
                    });
                  },
                ),
                Text("Perempuan"),
              ],
            ),
            SizedBox(height: 10),
            
            // Checkbox untuk Aktivitas Fisik
            Row(
              children: [
                Checkbox(
                  value: _isActive,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value ?? false;
                    });
                  },
                ),
                Text("Saya aktif secara fisik"),
              ],
            ),
            SizedBox(height: 20),
            
            // DatePicker untuk Tanggal Pemeriksaan
            ListTile(
              title: Text(
                "Tanggal Pemeriksaan: ${_selectedDate.toLocal()}".split(' ')[0],
              ),
              trailing: Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 10),

            // TimePicker untuk Waktu Pemeriksaan
            ListTile(
              title: Text("Waktu Pemeriksaan: ${_selectedTime.format(context)}"),
              trailing: Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
            SizedBox(height: 20),
            
            // Tombol Hitung BMI
            ElevatedButton(
              onPressed: _calculateBMI,
              child: Text('Hitung BMI'),
            ),
            SizedBox(height: 20),
            
            // Menampilkan Hasil BMI
            Text(
              'BMI Anda: ${_bmi.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Kategori: $_category',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
