import 'package:flutter/material.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:get/get.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/local_data.dart';
import 'package:provider/provider.dart';
import 'Exhibitor/Controllers/auth_provider.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
        ChangeNotifierProvider(create: (_) => LocalDataProvider()),
      ],
      child: GetMaterialApp(
        title: 'Medicall Exhibitor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.secondary),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
