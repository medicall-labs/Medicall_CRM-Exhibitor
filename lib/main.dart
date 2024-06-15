import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  PlatformDispatcher.instance.onError = (error, stack) {
    String errorMessage = "Error occurred: $error";
    var userDetails = GetStorage().read("login_data");
    if (userDetails['data'] != null) {
      errorMessage +=
          ' Mobile number : ${userDetails['data']['mobile_number']}';
    }
    FirebaseCrashlytics.instance.recordError(errorMessage, stack, fatal: true);
    return true;
  };

  await GetStorage.init();
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
