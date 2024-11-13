import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calculator');
              },
              child: Text('Kalkulator'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/temperature');
              },
              child: Text('Konversi Suhu'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/currency');
              },
              child: Text('Konversi Mata Uang'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/bmi');
              },
              child: Text('Kalkulator BMI'),
            ),
          ],
        ),
      ),
    );
  }
}
