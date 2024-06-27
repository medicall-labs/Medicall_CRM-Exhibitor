import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:medicall_exhibitor/Constants/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Announcements extends StatefulWidget {
  final List<dynamic> announcementsDetails;

  Announcements({super.key, required this.announcementsDetails});

  @override
  _AnnouncementsState createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Announcements',
          style: AppTextStyles.header2,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.announcementsDetails.length,
              itemBuilder: (context, index) {
                var announcement = widget.announcementsDetails[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              announcement['title'] ?? 'No Title',
                              style: AppTextStyles.header2,
                            ),
                            SizedBox(height: 10),
                            Html(
                              data: announcement['description'] ??
                                  'No Description',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.announcementsDetails.length,
              effect: WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Theme.of(context).primaryColor,
                dotColor: Colors.grey.shade300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

// old code
// import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:medicall_exhibitor/Constants/styles.dart';
//
// class Announcements extends StatelessWidget {
//   var announcementsDetails;
//
//   Announcements({super.key, required this.announcementsDetails});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Announcements',
//           style: AppTextStyles.header2,
//         ),
//       ),
//       body: PageView.builder(
//           itemCount: announcementsDetails.length,
//           itemBuilder: (context, index) {
//             var announcement = announcementsDetails[index];
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${index + 1} - ${announcement['title'] ?? 'No Title'}',
//                         style: AppTextStyles.header2,
//                       ),
//                       SizedBox(height: 10),
//                       Html(
//                         data: announcement['description'] ??
//                             'No Description',
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
