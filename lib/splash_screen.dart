import 'dart:async';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/bottom_nav_bar.dart';
import 'Auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  var UserDetails = GetStorage().read("local_store") != ''
      ? GetStorage().read("local_store")
      : '';
  int appOpenCount = 0;
  final InAppReview _inAppReview = InAppReview.instance;
  @override
  void initState() {
    super.initState();
    _loadAppOpenCount();
    _incrementAppOpenCount();
    checkForUpdate();
    if (appOpenCount == 36) {
      _inAppReview.requestReview();
    }
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) =>
                UserDetails != null ? BottomNavBar() : LoginPage()));
      }
    });
  }

  void _loadAppOpenCount() {
    final prefs = GetStorage();
    appOpenCount = prefs.read('app_open_count') ?? 0;
  }

  void _incrementAppOpenCount() {
    appOpenCount++;
    final prefs = GetStorage();
    prefs.write('app_open_count', appOpenCount);
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          update();
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  void update() async {
    print('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/Logo.png",
          width: 200,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
