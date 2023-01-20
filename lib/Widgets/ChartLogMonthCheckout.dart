import 'package:flutter/material.dart';
import 'package:visitorguard/Model/Chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: must_be_immutable
class ChartLogMonthCheckoutWidget extends StatelessWidget {
  String nameMonthYear;
  List<int> numDayscheckout;
  ChartLogMonthCheckoutWidget(String nameMonthYear, List<int> numDayscheckout){
    this.nameMonthYear = nameMonthYear;
    this.numDayscheckout = numDayscheckout;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth, screenHeight;
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    final List<LogMonthChart> dataChartcheckout = [
      for(int i=0;i<31;i++)
        new LogMonthChart(i+1, this.numDayscheckout[i]),
    ];
    List<charts.Series<LogMonthChart, int>> series = [
      charts.Series(
        id: 'check-out',
        data: dataChartcheckout,
        domainFn: (LogMonthChart sales, _) => sales.day,
        measureFn: (LogMonthChart sales, _) => sales.numInDay,
        colorFn: (LogMonthChart sales, _) => charts.ColorUtil.fromDartColor(Color(0xff00e6b8)),
        labelAccessorFn: (LogMonthChart sales, _) => sales.numInDay.toString(),
      ),
    ];
    return Container(
      constraints: BoxConstraints(minHeight: 500.0),
      width: screenWidth*0.9,
      height: screenHeight*0.4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 5,
          )
        ],
        color: Color(0xff232d37)
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: [
            Expanded(
              child: charts.LineChart(
                series, 
                animate: true,
                behaviors: [
                  new charts.SeriesLegend(
                    entryTextStyle: new charts.TextStyleSpec(
                      fontSize: 16, // size in Pts.
                      fontWeight: 'bold',
                      color: charts.MaterialPalette.white,
                    ),
                  )
                ],
                defaultRenderer: new charts.LineRendererConfig(
                  includeArea: true, 
                  //includePoints: true,
                  stacked: true,
                ),
                domainAxis: new charts.NumericAxisSpec(
                  renderSpec: new charts.SmallTickRendererSpec(
                    labelStyle: new charts.TextStyleSpec(
                      fontSize: 13, // size in Pts.
                      fontWeight: 'bold',
                      color: charts.MaterialPalette.white,
                    ),
                  )
                ),
                primaryMeasureAxis: new charts.NumericAxisSpec(
                  renderSpec: new charts.GridlineRendererSpec(
                    labelStyle: new charts.TextStyleSpec(
                      fontSize: 13, // size in Pts.
                      fontWeight: 'bold',
                      color: charts.MaterialPalette.white,
                    ), 
                  )
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
