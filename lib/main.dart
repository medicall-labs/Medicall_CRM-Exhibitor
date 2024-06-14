import 'package:flutter/material.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:get/get.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/history_provider.dart';
import 'package:medicall_exhibitor/Exhibitor/Controllers/local_data.dart';
import 'package:provider/provider.dart';
import 'Exhibitor/Controllers/appointment_provider.dart';
import 'Exhibitor/Controllers/auth_provider.dart';
import 'Exhibitor/Controllers/dashboard_provider.dart';
import 'Exhibitor/Controllers/event_provider.dart';
import 'Exhibitor/Controllers/products_provider.dart';
import 'Exhibitor/Controllers/profile_provider.dart';
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
        ChangeNotifierProvider(create: (context) => LocalDataProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => EventProvider()),
        ChangeNotifierProvider(create: (context) => AppointmentProvider()),
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
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
