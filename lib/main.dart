import 'package:flutter/material.dart';
import 'package:lingopanda/utils/config.dart';
import 'package:lingopanda/utils/theme/theme.dart';
import 'package:lingopanda/view/pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.instance.initialize().catchError((error, stackTrace) {
    return;
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        navigatorObservers: [Config.routeObserver],
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Config.instance.scaffoldMessengerKey,
        title: 'LingoPanda',
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorScheme: MaterialTheme.lightScheme().toColorScheme(),
          fontFamily: "poppins",
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: MaterialTheme.darkScheme().toColorScheme(),
          fontFamily: "poppins",
        ),
        themeMode: ThemeMode.system,
        home: const LoginScreen(),
      ),
    );
  }
}
