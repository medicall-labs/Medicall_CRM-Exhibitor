import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:medicall_exhibitor/Constants/app_color.dart';
import 'package:medicall_exhibitor/Exhibitor/Screens/Event%20Overview/event_overview.dart';

import 'Appointments/my_appointments.dart';
import 'My_History/history.dart';
import 'Products/all_product.dart';

class BottomNavBar extends StatefulWidget {

  int? currentPage;
   BottomNavBar({super.key, this.currentPage});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  late int currentIndex;
  List screens = [
    Placeholder(
      child: Center(child: Text('Dashboard')),
    ),
    Appointment(),
    EventOverview(),
    Products(),
    MyHistory(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentPage ?? 2;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentIndex = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor:
            currentIndex == 2 ? AppColor.primary : Colors.grey.shade400,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            AppColor.secondary,
            BlendMode.modulate,
          ),
          child: Lottie.asset('assets/lottie/dashboard.json'),
        ),
        // const Icon(
        //   Icons.grid_view_outlined,
        //   color: Colors.white,
        //   size: 30,
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 0;
                });
              },
              icon: Icon(
                Icons.event,
                size: 30,
                color:
                    currentIndex == 0 ? AppColor.primary : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: Icon(
                Icons.app_registration_outlined,
                size: 30,
                color:
                    currentIndex == 1 ? AppColor.primary : Colors.grey.shade400,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color:
                    currentIndex == 3 ? AppColor.primary : Colors.grey.shade400,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 4;
                });
              },
              icon: Icon(
                Icons.history,
                size: 30,
                color:
                    currentIndex == 4 ? AppColor.primary : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
