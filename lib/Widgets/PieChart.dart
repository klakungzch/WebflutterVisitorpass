import 'package:flutter/material.dart';
import 'package:visitorguard/Model/Chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: must_be_immutable
class StatusPieChartWidget extends StatelessWidget {
  int numTrue;
  int numFalse;
  StatusPieChartWidget(int numTrue,int numFalse){
    this.numTrue = numTrue;
    this.numFalse = numFalse;
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth, screenHeight;
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    final List<StatusBarChart> dataBarChart = [
      StatusBarChart(
        'True',
        this.numTrue,
        charts.ColorUtil.fromDartColor(Colors.green),
      ),
        StatusBarChart(
        'False',
        this.numFalse,
        charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];
    List<charts.Series<StatusBarChart, String>> series = [
      charts.Series(
        id: 'Status',
        data: dataBarChart,
        domainFn: (StatusBarChart sales, _) => sales.status,
        measureFn: (StatusBarChart sales, _) => sales.numStatus,
        colorFn: (StatusBarChart sales, _) => sales.barColor,
        labelAccessorFn: (StatusBarChart row, _) => '${row.numStatus}',
      )
    ];
    if(screenWidth>800)
      return Container(
        constraints: BoxConstraints(minHeight: 500.0),
        height: screenHeight*0.4,
        width: screenWidth*0.4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1, color: Color.fromARGB(255, 191, 191, 191))
          ),
          child: Column(
            children: [
              SizedBox(height: 15),
              Text(
                'UserGuard Status PieChart',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: charts.PieChart(
                  series, 
                  animate: true,
                  behaviors: [
                    new charts.DatumLegend(
                      position: charts.BehaviorPosition.end,
                      outsideJustification: charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: new EdgeInsets.only(right: 15, bottom: 5.0),
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.black,
                          fontSize: 16),
                    ),
                  ],
                  defaultRenderer: new charts.ArcRendererConfig(
                    arcRendererDecorators: [new charts.ArcLabelDecorator()]
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    else
      return Container(
        constraints: BoxConstraints(minHeight: 500.0),
        height: screenHeight*0.4,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1, color: Color.fromARGB(255, 191, 191, 191))
          ),
          child: Column(
            children: [
              SizedBox(height: 15),
              Text(
                'UserGuard Status PieChart',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: charts.PieChart(
                  series, 
                  animate: true,
                  behaviors: [
                    new charts.DatumLegend(
                      position: charts.BehaviorPosition.end,
                      outsideJustification: charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: new EdgeInsets.only(right: 15, bottom: 5.0),
                      entryTextStyle: charts.TextStyleSpec(
                          color: charts.MaterialPalette.black,
                          fontSize: 16),
                    ),
                  ],
                  defaultRenderer: new charts.ArcRendererConfig(
                    arcRendererDecorators: [new charts.ArcLabelDecorator()]
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}