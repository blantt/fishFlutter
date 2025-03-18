import 'package:flutter/material.dart';

void main() => runApp(classSelectTime());

class classSelectTime extends StatelessWidget {
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
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectTime,
              child: Text('SELECT TIME'),
            ),
            SizedBox(height: 8),
            Text(
              'Selected time: ${_time.format(context)}',
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
    colorScheme: _shrineColorScheme,
    primaryColor: shrinePink100,
    scaffoldBackgroundColor: shrineBackgroundWhite,
    cardColor: shrineBackgroundWhite,
 

    // ⚠️ `accentColor` 已移除，改用 colorScheme.secondary
    // accentColor: shrineBrown900,  // ❌ 錯誤
    // ✅ 用 colorScheme 替代
    secondaryHeaderColor: _shrineColorScheme.secondary,

    // ⚠️ `toggleableActiveColor` 已移除，改用 colorScheme.secondary
    // toggleableActiveColor: shrinePink400,  // ❌ 錯誤
    // ✅ 用 colorScheme.secondary
    unselectedWidgetColor: _shrineColorScheme.secondary,

    // ⚠️ `buttonColor` 被移除，應該用 textButtonTheme
    // buttonColor: shrinePink100,  // ❌ 錯誤
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: shrinePink100),
    ),

    // ⚠️ `textSelectionColor` 被移除，改用 textSelectionTheme
    // textSelectionColor: shrinePink100,  // ❌ 錯誤
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: shrinePink100,
      selectionColor: shrinePink100,
      selectionHandleColor: shrinePink400,
    ),

    buttonTheme: const ButtonThemeData(
      colorScheme: _shrineColorScheme,
      textTheme: ButtonTextTheme.normal,
    ),

    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),

    // ⚠️ `accentTextTheme` 被移除，直接刪除這行
    // accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),  // ❌ 錯誤

    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: shrineBrown900);
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        bodySmall: base.bodySmall?.copyWith(
          // ⚠️ `caption` → `bodySmall`
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        labelLarge: base.labelLarge?.copyWith(
          // ⚠️ `button` → `labelLarge`
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
  primaryContainer: shrineBrown900, // ⚠️ `primaryVariant` → `primaryContainer`
  secondary: shrinePink50,
  secondaryContainer: shrineBrown900, // ⚠️ `secondaryVariant` → `secondaryContainer`
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
