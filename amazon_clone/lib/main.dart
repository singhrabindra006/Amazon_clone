import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/features/auth/screen/auth_screen.dart';
import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await resolveApiUri();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (cotext) => UserProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariable.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariable.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: GlobalVariable.secondaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GlobalVariable.secondaryColor,
            foregroundColor: Colors.black,
          ),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthScreen(),
    );
  }
}
