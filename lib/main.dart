
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_firebase/pages/main_page.dart';
import 'package:todo_app_firebase/thme/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ValueNotifier<bool> _isDarkMode = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _isDarkMode.value = isDarkMode;
  }

  Future<void> _saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ToDoApp(
            isDarkMode: isDarkMode,
            onThemeChanged: (isDarkMode) {
              _isDarkMode.value = isDarkMode;
              _saveTheme(isDarkMode);
            },
          ),
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: isDarkMode
                  ? DarkTheme.appbar
                  : LightTheme.appbar,
            ),
          ),
        );
      },
    );
  }
}
