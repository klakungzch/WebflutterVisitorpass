import 'package:flutter/material.dart';
import 'package:visitorguard/Model/Chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: must_be_immutable
class ChartLogDayWidget extends StatelessWidget {
  String nameDay;
  List<int> numDayscheckin;
  ChartLogDayWidget(String nameDay, List<int> numDayscheckin){
    this.nameDay = nameDay;
    this.numDayscheckin = numDayscheckin;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth, screenHeight;
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    final List<LogDayChart> dataChartcheckin = [
      for(int i=0;i<24;i++)
        new LogDayChart(i, this.numDayscheckin[i]),
    ];
    /*final List<LogDayChart> dataChartcheckout = [
      for(int i=0;i<24;i++)
        new LogDayChart(i, this.numDayscheckout[i]),
    ];*/
    List<charts.Series<LogDayChart, int>> series = [
      charts.Series(
        id: 'check-in',
        data: dataChartcheckin,
        domainFn: (LogDayChart sales, _) => sales.time,
        measureFn: (LogDayChart sales, _) => sales.numInTime,
        colorFn: (LogDayChart sales, _) => charts.ColorUtil.fromDartColor(Color(0xff00ff80)),
        labelAccessorFn: (LogDayChart sales, _) => sales.numInTime.toString(),
      ),
      /*charts.Series(
        id: 'check-out',
        data: dataChartcheckout,
        domainFn: (LogDayChart sales, _) => sales.time,
        measureFn: (LogDayChart sales, _) => sales.numInTime,
        colorFn: (LogDayChart sales, _) => charts.ColorUtil.fromDartColor(Color(0xffff0000)),
        labelAccessorFn: (LogDayChart sales, _) => sales.numInTime.toString(),
      ),*/
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
