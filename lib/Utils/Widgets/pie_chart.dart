import 'dart:math';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class PieChart extends StatelessWidget {
  Map insights;
  PieChart({super.key, required this.insights});

  @override
  Widget build(BuildContext context) {
    List<OrdinalData> ordinalDataList = [
      OrdinalData(
          domain: 'Scheduled',
          measure: insights['scheduled_count'],
          color: Color(0xff3abfaf)),
      OrdinalData(
          domain: 'Rescheduled',
          measure: insights['rescheduled_count'],
          color: Color(0xffbf3a4a)),
      // OrdinalData(
      //     domain: 'Confirmed Count', measure: 9, color: Colors.purple[300]),
      OrdinalData(
          domain: 'No Show',
          measure: insights['lapsed_count'],
          color: Color(0xff6c3abf)),
      OrdinalData(
          domain: 'Cancelled',
          measure: insights['cancelled_count'],
          color: Color(0xff3abf6c)),
      OrdinalData(
          domain: 'Completed',
          measure: insights['completed_count'],
          color: Color(0xff8dbf3a)),
    ];
    return AspectRatio(
      aspectRatio: 1,
      child: DChartPieO(
        data: ordinalDataList,
        customLabel: (ordinalData, index) {
          return "${ordinalData.measure}";
        },
        configRenderPie: ConfigRenderPie(
          arcLabelDecorator: ArcLabelDecorator(
            labelPosition: ArcLabelPosition.auto,
            insideLabelStyle: LabelStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            outsideLabelStyle: LabelStyle(
              color: Colors.red,
              fontSize: 12,
            ),
            labelPadding: 0,
            leaderLineStyle: ArcLabelLeaderLineStyle(
                color: Colors.black12, length: 10, thickness: 2),
            showLeaderLines: true,
          ),

          arcLength: 2 * pi,
          arcWidth: 20,
          startAngle: -pi / 3,
          // strokeWidthPx: 2,
        ),
      ),
    );
  }
}
