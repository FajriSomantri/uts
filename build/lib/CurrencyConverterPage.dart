group('Pengujian Konversi Mata Uang', () {
  testWidgets('Konversi USD ke IDR dengan jumlah standar', (WidgetTester tester) async {
    // Persiapan Pengujian
    await tester.pumpWidget(const MyApp());

    // Navigasi ke Halaman Konversi
    await tester.tap(find.text('Konversi Mata Uang'));
    await tester.pumpAndSettle();

    // Input Data Konversi
    final amountField = find.byType(TextField);
    await tester.enterText(amountField, '100');
    await tester.pumpAndSettle();

    // Pilih Mata Uang
    await tester.tap(find.text('USD'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('IDR'));
    await tester.pumpAndSettle();

    // Eksekusi Konversi
    await tester.tap(find.text('Konversi Uang'));
    await tester.pumpAndSettle();

    // Verifikasi Hasil
    expect(find.text('Jumlah Terkonversi: 1500000.0 IDR'), findsOneWidget);
  });

  testWidgets('Konversi dengan jumlah minimum', (WidgetTester tester) async {
    // Persiapan Pengujian
    await tester.pumpWidget(const MyApp());

    // Navigasi ke Halaman Konversi
    await tester.tap(find.text('Konversi Mata Uang'));
    await tester.pumpAndSettle();

    // Input Jumlah Minimum
    final amountField = find.byType(TextField);
    await tester.enterText(amountField, '1');
    await tester.pumpAndSettle();

    // Pilih Mata Uang
    await tester.tap(find.text('USD'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('IDR'));
    await tester.pumpAndSettle();

    // Eksekusi Konversi
    await tester.tap(find.text('Konversi Uang'));
    await tester.pumpAndSettle();

    // Verifikasi Hasil
    expect(find.text('Jumlah Terkonversi: 15000.0 IDR'), findsOneWidget);
  });

  testWidgets('Konversi dengan mata uang berbeda', (WidgetTester tester) async {
    // Persiapan Pengujian
    await tester.pumpWidget(const MyApp());

    // Navigasi ke Halaman Konversi
    await tester.tap(find.text('Konversi Mata Uang'));
    await tester.pumpAndSettle();

    // Input Data Konversi
    final amountField = find.byType(TextField);
    await tester.enterText(amountField, '50');
    await tester.pumpAndSettle();

    // Pilih Mata Uang Alternatif
    await tester.tap(find.text('EUR'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('IDR'));
    await tester.pumpAndSettle();

    // Eksekusi Konversi
    await tester.tap(find.text('Konversi Uang'));
    await tester.pumpAndSettle();

    // Verifikasi Hasil
    expect(find.text('Jumlah Terkonversi: 850000.0 IDR'), findsOneWidget);
  });

  testWidgets('Validasi input tidak valid', (WidgetTester tester) async {
    // Persiapan Pengujian
    await tester.pumpWidget(const MyApp());

    // Navigasi ke Halaman Konversi
    await tester.tap(find.text('Konversi Mata Uang'));
    await tester.pumpAndSettle();

    // Input Data Tidak Valid
    final amountField = find.byType(TextField);
    await tester.enterText(amountField, '-10');
    await tester.pumpAndSettle();

    // Pilih Mata Uang
    await tester.tap(find.text('USD'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('IDR'));
    await tester.pumpAndSettle();

    // Eksekusi Konversi
    await tester.tap(find.text('Konversi Uang'));
    await tester.pumpAndSettle();

    // Verifikasi Pesan Error
    expect(find.text('Jumlah tidak valid'), findsOneWidget);
  });
}