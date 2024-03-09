import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';
import '../helpers/preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Hive initialization
  await Pref.initializeHive();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nucleus VPN',
      home: HomeScreen(),

      // Theme
      theme:
          ThemeData(appBarTheme: AppBarTheme(centerTitle: true, elevation: 4)),

      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // Dark Theme
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 4),
        scaffoldBackgroundColor: bgColor, // Set a custom background color
        // Add other dark theme configurations here
      ),
    );
  }
}

extension AppTheme on ThemeData {
  Color get lightText => Pref.isDarkMode ? Colors.white : Colors.black;
  Color get lighSubtitleText => Pref.isDarkMode ? Colors.white70 : Colors.black;
  Color get bottomNav => Pref.isDarkMode ? bgColor : Colors.blueAccent;
  Color get borderColor => Pref.isDarkMode ? Colors.deepPurple : Colors.black;
}

darkModeButton(Color color) {
  return IconButton(
    color: color,
    onPressed: () {
      Get.changeThemeMode(Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
      Pref.isDarkMode = !Pref.isDarkMode;
    },
    icon: Icon(
      Icons.brightness_medium,
      size: 26,
    ),
  );
}

get bgColor => Pref.isDarkMode ? Color.fromARGB(255, 15, 8, 33) : Colors.white;
