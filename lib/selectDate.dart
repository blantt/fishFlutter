import 'package:flutter/material.dart';

void main() => runApp(selectDate());

class selectDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Picker Themed Demo',
      debugShowCheckedModeBanner: false,
      theme: _buildShrineTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _date = DateTime(2020, 11, 17);

  void _backpage() {
    //返迴上頁路由
    Navigator.pop(context, '');

    //判斷是否有上一層路由
    //Navigator.canPop(context);
  }

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              child: Text('返回'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              onPressed: _backpage,
              child: Text('返迴上頁'),
            ),
            ElevatedButton(
              onPressed: _selectDate,
              child: Text('SELECT DATE'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected date: $_date',
            ),
          ],
        ),
      ),
    );
  }
}

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: _shrineColorScheme.copyWith(
      secondary: shrineBrown900, // 取代 accentColor
      error: shrineErrorRed,
    ),
    primaryColor: shrinePink100, // Flutter 3.0 仍然保留
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: shrinePink100, // 取代 textSelectionColor
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: shrinePink100, // 取代 buttonColor
      ),
    ),
    iconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
  );
  // return base.copyWith(
  //   colorScheme: _shrineColorScheme,
  //   toggleableActiveColor: shrinePink400,
  //   accentColor: shrineBrown900,
  //   primaryColor: shrinePink100,
  //   buttonColor: shrinePink100,
  //   scaffoldBackgroundColor: shrineBackgroundWhite,
  //   cardColor: shrineBackgroundWhite,
  //   textSelectionColor: shrinePink100,
  //   errorColor: shrineErrorRed,
  //   buttonTheme: const ButtonThemeData(
  //     colorScheme: _shrineColorScheme,
  //     textTheme: ButtonTextTheme.normal,
  //   ),
  //   primaryIconTheme: _customIconTheme(base.iconTheme),
  //   textTheme: _buildShrineTextTheme(base.textTheme),
  //   primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
  //   accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
  //   iconTheme: _customIconTheme(base.iconTheme),
  // );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        bodySmall: base.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: shrineBrown900,
        bodyColor: shrineBrown900,
      );
}

const ColorScheme _shrineColorScheme = ColorScheme(
  primary: shrinePink400,
  primaryContainer: shrineBrown900, // 修正 primaryVariant
  secondary: shrinePink50,
  secondaryContainer: shrineBrown900, // 修正 secondaryVariant
  surface: shrineSurfaceWhite,
  background: shrineBackgroundWhite,
  error: shrineErrorRed,
  onPrimary: shrineBrown900,
  onSecondary: shrineBrown900,
  onSurface: shrineBrown900,
  onBackground: shrineBrown900,
  onError: shrineSurfaceWhite,
  brightness: Brightness.light,
);
const Color shrinePink50 = Color(0xFFFEEAE6);
const Color shrinePink100 = Color(0xFFFEDBD0);
const Color shrinePink300 = Color(0xFFFBB8AC);
const Color shrinePink400 = Color(0xFFEAA4A4);

const Color shrineBrown900 = Color(0xFF442B2D);
const Color shrineBrown600 = Color(0xFF7D4F52);

const Color shrineErrorRed = Color(0xFFC5032B);

const Color shrineSurfaceWhite = Color(0xFFFFFBFA);
const Color shrineBackgroundWhite = Colors.white;

const defaultLetterSpacing = 0.03;
