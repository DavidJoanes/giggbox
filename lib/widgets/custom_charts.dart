import 'dart:math';

import 'package:flutter/material.dart';
import 'package:giggbox/widgets/buttons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class CustomLineChart extends StatefulWidget {
  CustomLineChart({super.key, required this.size});
  late Size size;

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<_BookingsData> data = [
    _BookingsData('Jan', Random().nextInt(20) + 12),
    _BookingsData('Feb', Random().nextInt(20) + 24),
    _BookingsData('Mar', Random().nextInt(20) + 32),
    _BookingsData('Apr', Random().nextInt(20) + 22),
    _BookingsData('May', Random().nextInt(20) + 56),
    _BookingsData('Jun', Random().nextInt(20) + 34),
    _BookingsData('Jul', Random().nextInt(20) + 87),
    _BookingsData('Aug', Random().nextInt(20) + 34),
    _BookingsData('Sep', Random().nextInt(20) + 22),
    _BookingsData('Oct', Random().nextInt(20) + 13),
    _BookingsData('Nov', Random().nextInt(20) + 43),
    _BookingsData('Dec', Random().nextInt(20) + 32),
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: widget.size.height * 0.4,
            width: widget.size.width * 0.39,
            child: Column(children: [
              //Initialize the chart widget
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(
                    alignment: ChartAlignment.near,
                    text: "Monthly Bookings",
                  ),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<_BookingsData, String>>[
                    LineSeries<_BookingsData, String>(
                        dataSource: data,
                        xValueMapper: (_BookingsData sales, _) => sales.year,
                        yValueMapper: (_BookingsData sales, _) => sales.bookings,
                        name: 'Bookings',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //Initialize the spark charts widget
                  child: SfSparkLineChart.custom(
                    //Enable the trackball
                    trackball: const SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: const SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    xValueMapper: (int index) => data[index].year,
                    yValueMapper: (int index) => data[index].bookings,
                    // dataCount: 12,
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}

class _BookingsData {
  _BookingsData(this.year, this.bookings);

  final String year;
  final double bookings;
}

class CustomBarChart extends StatefulWidget {
  CustomBarChart({super.key, required this.size});
  late Size size;

  @override
  State<CustomBarChart> createState() => _CustomBarChartState();
}

class _CustomBarChartState extends State<CustomBarChart> {
  List<_EarningsData> data = [
    _EarningsData('Jan', Random().nextInt(20000) + 1200),
    _EarningsData('Feb', Random().nextInt(20000) + 2400),
    _EarningsData('Mar', Random().nextInt(20000) + 3200),
    _EarningsData('Apr', Random().nextInt(20000) + 2200),
    _EarningsData('May', Random().nextInt(20000) + 5600),
    _EarningsData('Jun', Random().nextInt(20000) + 3400),
    _EarningsData('Jul', Random().nextInt(20000) + 8700),
    _EarningsData('Aug', Random().nextInt(20000) + 3400),
    _EarningsData('Sep', Random().nextInt(20000) + 2200),
    _EarningsData('Oct', Random().nextInt(20000) + 1300),
    _EarningsData('Nov', Random().nextInt(20000) + 4300),
    _EarningsData('Dec', Random().nextInt(20000) + 3200),
  ];
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Initialize the chart widget
          SizedBox(
            width: widget.size.width * 0.39,
            child: ListTile(
              title: Text("Earnings",
                  style: GoogleFonts.archivo(
                      textStyle: TextStyle(
                          fontSize: widget.size.width * 0.01,
                          color: constantValues.whiteColor,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal))),
              subtitle: Text(
                "\$5,400",
                style: GoogleFonts.archivo(
                    textStyle: TextStyle(
                        fontSize: widget.size.width * 0.017,
                        color: constantValues.whiteColor,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal)),
              ),
            ),
          ),
          SizedBox(
            // height: widget.size.height * 0.38,
            width: widget.size.width * 0.39,
            child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis:
                    NumericAxis(minimum: 0, interval: 10),
                tooltipBehavior: TooltipBehavior(enable: true),
                plotAreaBackgroundColor: constantValues.transparentColor,
                series: <CartesianSeries<_EarningsData, String>>[
                  ColumnSeries<_EarningsData, String>(
                      dataSource: data,
                      xValueMapper: (_EarningsData data, _) => data.year,
                      yValueMapper: (_EarningsData data, _) => data.earnings,
                      name: 'Earnings',
                      color: constantValues.primaryColor)
                ]),
          ),
        ],
      ),
    );
  }
}

class _EarningsData {
  _EarningsData(this.year, this.earnings);

  final String year;
  final double earnings;
}
