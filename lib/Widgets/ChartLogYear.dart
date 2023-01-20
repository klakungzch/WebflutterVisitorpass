import 'package:flutter/material.dart';
import 'package:visitorguard/Model/Chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: must_be_immutable
class ChartLogYearWidget extends StatelessWidget {
  String nameYear;
  List<int> numMonthscheckin;
  List<int> numMonthscheckout;
  ChartLogYearWidget(String nameYear, List<int> numMonthscheckin, List<int> numMonthscheckout){
    this.nameYear = nameYear;
    this.numMonthscheckin = numMonthscheckin;
    this.numMonthscheckout = numMonthscheckout;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth, screenHeight;
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    List<String> abMonth = ['Jan.', 'Feb.', 'Mar.', 'Apr.', 'May.', 'Jun.', 'Jul.', 'Aug.', 'Sep.', 'Oct.', 'Nov.', 'Dec.'];
    final List<LogYearChart> dataChartcheckin = [
      for(int i=0;i<12;i++)
        new LogYearChart(abMonth[i], this.numMonthscheckin[i]),
    ];
    final List<LogYearChart> dataChartcheckout = [
      for(int i=0;i<12;i++)
        new LogYearChart(abMonth[i], this.numMonthscheckout[i]),
    ];
    List<charts.Series<LogYearChart, String>> series = [
      charts.Series(
        id: 'check-in',
        data: dataChartcheckin,
        domainFn: (LogYearChart sales, _) => sales.month,
        measureFn: (LogYearChart sales, _) => sales.numInMonth,
        colorFn: (LogYearChart sales, _) => charts.ColorUtil.fromDartColor(Color(0xff00e6b8)),
        labelAccessorFn: (LogYearChart sales, _) => '${sales.numInMonth.toString()}',
      ),
      charts.Series(
        id: 'check-out',
        data: dataChartcheckout,
        domainFn: (LogYearChart sales, _) => sales.month,
        measureFn: (LogYearChart sales, _) => sales.numInMonth,
        colorFn: (LogYearChart sales, _) => charts.ColorUtil.fromDartColor(Color(0xff00ff80)),
        labelAccessorFn: (LogYearChart sales, _) => '${sales.numInMonth.toString()}',
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
              child: charts.BarChart(
                series, 
                animate: true,
                barGroupingType: charts.BarGroupingType.grouped,
                behaviors: [new charts.SeriesLegend(
                  entryTextStyle: new charts.TextStyleSpec(
                    fontSize: 16, // size in Pts.
                    fontWeight: 'bold',
                    color: charts.MaterialPalette.white,
                  ),
                )],
                barRendererDecorator: new charts.BarLabelDecorator<String>(),
                defaultRenderer: new charts.BarRendererConfig(
                  cornerStrategy: const charts.ConstCornerStrategy(30)
                ),
                domainAxis: new charts.OrdinalAxisSpec(
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
