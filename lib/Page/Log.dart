import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:visitorguard/Language/UrlImage.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Widgets/ChartLogDay.dart';
import 'package:visitorguard/Widgets/ChartLogDayCheckout.dart';
import 'package:visitorguard/Widgets/ChartLogMonth.dart';
import 'package:visitorguard/Widgets/ChartLogMonthCheckout.dart';
import 'package:visitorguard/Widgets/ColorSet.dart';
import 'package:visitorguard/Widgets/Drawer.dart';
import 'package:visitorguard/Widgets/ChartLogYear.dart';
import 'package:visitorguard/Widgets/Margin.dart';
import 'package:visitorguard/Widgets/TextField.dart';

// ignore: must_be_immutable
class Log extends StatefulWidget {
  String dataSearch;
  String mode;
  int pageSelection;
  String lang;
  int numPage;
  Log(String dataSearch, String mode, int pageSelection, String lang, int numPage){
    this.dataSearch = dataSearch;
    this.mode = mode;
    this.pageSelection = pageSelection;
    this.lang = lang;
    this.numPage = numPage;
  }
  @override
  _LogState createState() => _LogState(this.dataSearch, this.mode, this.pageSelection, this.lang, this.numPage);
}

class _LogState extends State<Log> {
  String dataSearch;
  String mode;
  int pageSelection;
  String lang;
  int numPage;
  _LogState(String dataSearch, String mode, int pageSelection, String lang, int numPage){
    this.dataSearch = dataSearch;
    this.mode = mode;
    this.pageSelection = pageSelection;
    this.lang = lang;
    this.numPage = numPage;
  }
  
  @override
  void initState() {
    super.initState();
  }

  Query users = FirebaseFirestore.instance.collection('saveLog').orderBy('id', descending: true);
  var word = new Word(); // class of language words
  var url = new UrlImage(); // class of url Image
  var colorset = new ColorSet(); // class of main color 
  bool checkNotfoundData = true;
  List<int> numMonthscheckin = []; List<int> numMonthscheckout = [];
  
  double screenWidth, screenHeight;
  TextEditingController searchBarController = TextEditingController();
  List<String> labels = ['List Log', 'Chart Year', 'Chart Month', 'Chart Day'];
  List<String> years = ['2020', '2021', '2022','2023'];
  List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  String dateNow = DateTime.now().toIso8601String();
  String dayNow, monthNow, yearNow;
  String monthChoose, yearChoose, dayChoose;
  String nameMonth,nameDay;
  String nameMonthChoose;
  String fullDateDay;
  int _currentSelection = 0;
  String dayPick, monthPick ,yearPick;
  String datePattern;

  Widget build(BuildContext context) {
    int pagefront;
    int pageback;
    int maxPage;

    // set 0 in checkin/checkout each month
    for(int i=0;i<12;i++){
      numMonthscheckin.add(0);
      numMonthscheckout.add(0);
    }
    
    List<String> split1 = dateNow.split('T');
    List<String> split2 = split1[0].split('-');
    yearNow = split2[0];
    yearNow = yearNow.substring(2);
    monthNow = split2[1];
    dayNow = split2[2];

    yearChoose = yearNow;
    monthChoose = monthNow;
    dayChoose = dayNow;
    if(monthNow.startsWith('0')) monthNow = monthNow.substring(1);
    if(dayNow.startsWith('0')) dayNow = dayNow.substring(1);
    fullDateDay = dayNow+'/'+monthNow+'/20'+yearNow; // Date now

    if(this.pageSelection != null){
      _currentSelection = this.pageSelection;
    }

    if(this.mode == '1'){
      if(searchBarController.text != '' || searchBarController.text != null)
        searchBarController.text = this.dataSearch;
    }
    if(this.mode == '2'){
      if(this.dataSearch == null) {
        searchBarController.text = fullDateDay;
        this.dataSearch = searchBarController.text;
      }
      else if(this.dataSearch != null && dataSearch.contains('_mode2')) {
        List<String> spt1 = dataSearch.split('_mode2');
        fullDateDay = spt1[0];
        searchBarController.text = fullDateDay;
        this.dataSearch =  searchBarController.text;
      }
    }
    if(this.mode == '3'){
      if(this.dataSearch != '' || this.dataSearch != null){
        List<String> spt = dataSearch.split('spt');
        yearChoose = '20${spt[0]}';
        monthChoose = spt[1];
        
        if(monthChoose.startsWith('0'))
          monthChoose = monthChoose.substring(1);
      }
    }
    if(this.mode == '4'){
      if(this.dataSearch != '' || this.dataSearch != null)
        yearChoose = '20${this.dataSearch}';
    }
    nameMonthChoose = months[int.parse(monthChoose)-1];
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(
                'Visitor - Guard',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Prompt',
                ),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, lang, 1)));
              },
            ),
            SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 6),
                    ],
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, 'TH', 1)));
                    }, 
                    child: Image.network(
                      '${url.imgThai}',
                      width: 35,
                      height: 20,
                      fit:BoxFit.fill
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 35,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 6),
                    ],
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, 'EN', 1)));
                    }, 
                    child: Image.network(
                      '${url.imgEng}',
                      width: 35,
                      height: 20,
                      fit:BoxFit.fill
                    ),
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
          ],
        ),
        backgroundColor: colorset.blueOne,
      ),
      drawer: drawer(context, this.lang),
      body: FutureBuilder(
        future: getDataLog(),
        builder: (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }  
          else if (snapshot.connectionState == ConnectionState.done) {
            for(int i=0;i<numMonthscheckin.length;i++){
              numMonthscheckin[i] = 0;
              numMonthscheckout[i] = 0;
            }
            print(dataSearch);
            // set about datapage
            if(dataSearch != null)
              for(int i=0;i<snapshot.data.length;i++){
                print('${snapshot.data[i]} /// $dataSearch');
                if(snapshot.data[i][1].contains(dataSearch) || snapshot.data[i][1].contains(dataSearch)){
                  checkNotfoundData = false;
                  break;
                }
              }
            if(dataSearch == null)
              checkNotfoundData = false;
            pagefront = (numPage*15)-15;
            pageback = numPage*15;
            if(pageback>snapshot.data.length)
              pageback = snapshot.data.length;
            maxPage = (snapshot.data.length/15).ceil();

            return new SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                child: Column(
                  children: [
                    Center(
                      child: MaterialSegmentedControl(
                        children: {
                          0: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '${word.tabbarName1['$lang']}', 
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontFamily: 'Prompt')
                            ),
                          ),
                          1: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '${word.tabbarName2['$lang']}', 
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontFamily: 'Prompt')
                            ),
                          ),
                          2: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '${word.tabbarName3['$lang']}', 
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontFamily: 'Prompt')
                            ),
                          ),
                          3: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              '${word.tabbarName4['$lang']}', 
                              textAlign: TextAlign.center, 
                              style: TextStyle(fontFamily: 'Prompt')
                            ),
                          ),
                        },
                        selectionIndex: _currentSelection,
                        borderColor: Colors.grey,
                        selectedColor: colorset.blueOne,
                        unselectedColor: Colors.white,
                        borderRadius: 32.0,
                        onSegmentChosen: (index) {
                          if(index == 0){
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => Log(null, '1', index, this.lang, 1), 
                            ));
                          }
                          else if(index == 1){
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => Log(fullDateDay, '2', index, this.lang, 1),
                            ));
                          }
                          else if(index == 2){
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => Log(yearNow+'spt'+monthNow, '3', index, this.lang, 1), 
                            ));
                          }
                          else if(index == 3){
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => Log(yearNow, '4', index, this.lang, 1), 
                            ));
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    if(_currentSelection == 0)      // ALL LOG
                      Column(
                        children: [
                          Container(
                            width: screenWidth*0.9,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  constraints: BoxConstraints(maxHeight: 45.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                      )
                                    ],
                                    color: colorset.blueOne,
                                  ),
                                  child: Text(
                                    '${word.overview['$lang']}',
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          if(screenWidth>1080)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                freeArea(),
                                Row(
                                  children: [
                                    FutureBuilder(
                                      future: getDataCheck('All'),
                                      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          return buildTotal(snapshot.data.toString(), dataSearch, 
                                            Color(0xff00cc00), Color(0xff00e600), 
                                            '${word.total1['$lang']}', (screenWidth*0.89)/3, 'col1');
                                        } 
                                        else { 
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }
                                    ),
                                    SizedBox(width: 10,),
                                    FutureBuilder(
                                      future: getDataCheck('TodayCheckin'),
                                      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          return buildTotal(snapshot.data.toString(), dataSearch, 
                                            Color(0xffff6600), Color(0xffffcc00), 
                                            '${word.total2['$lang']}', (screenWidth*0.89)/3, 'col2');
                                        } 
                                        else { 
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }
                                    ),
                                    SizedBox(width: 10,),
                                    FutureBuilder(
                                      future: getDataCheck('TodayCheckout'),
                                      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                        if (snapshot.connectionState == ConnectionState.done) {
                                          return buildTotal(snapshot.data.toString(), dataSearch,
                                            Color(0xff0033cc), Colors.blueAccent, 
                                            '${word.total3['$lang']}', (screenWidth*0.89)/3, 'col3');
                                        } 
                                        else { 
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }
                                    ),
                                  ],
                                ),
                                freeArea(),
                              ],
                            )
                          else
                            Column(
                              children: [
                                FutureBuilder(
                                  future: getDataCheck('All'),
                                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return buildTotal(snapshot.data.toString(), dataSearch, Color(0xff00cc00),
                                        Color(0xff00e600), '${word.total1['$lang']}', (screenWidth*0.9), 'col1');
                                    } 
                                    else { 
                                      return CircularProgressIndicator();
                                    }
                                  }
                                ),
                                SizedBox(height: 10,),
                                FutureBuilder(
                                  future: getDataCheck('TodayCheckin'),
                                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return buildTotal(snapshot.data.toString(), dataSearch, Color(0xffff6600), 
                                        Color(0xffffcc00), '${word.total2['$lang']}', (screenWidth*0.9), 'col2');
                                    } 
                                    else { 
                                      return CircularProgressIndicator();
                                    }
                                  }
                                ),
                                SizedBox(height: 10,),
                                FutureBuilder(
                                  future: getDataCheck('TodayCheckout'),
                                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      return buildTotal(snapshot.data.toString(), dataSearch, Color(0xff0033cc), 
                                        Colors.blueAccent, '${word.total3['$lang']}', (screenWidth*0.9), 'col3');
                                    } 
                                    else { 
                                      return CircularProgressIndicator();
                                    }
                                  }
                                ),
                              ],
                            ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              freeArea(),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${word.date['$lang']}',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      textFieldSearch(searchBarController, '${word.chooseDate['$lang']}', screenWidth*0.3, 50.0),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      buttonDate('1', 0),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      buttonShowAll(),
                                    ],
                                  ),
                                ],
                              ),
                              freeArea(),
                            ],
                          ),
                          SizedBox(height: 15),
                          if(checkNotfoundData == true)
                            Container(
                              width: screenWidth*0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${word.page['$lang']} : $numPage (0)',
                                    style: TextStyle(fontSize: 16, fontFamily: 'Prompt'),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined), 
                                    onPressed: null,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios_outlined), 
                                    onPressed: null,
                                  ),
                                ]
                              )
                            )
                          else if(numPage == 1 && snapshot.data.length < 15)
                            Container(
                              width: screenWidth*0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${word.page['$lang']} : $numPage (1-${snapshot.data.length} ${word.of['$lang']} ${snapshot.data.length})',
                                    style: TextStyle(fontSize: 16, fontFamily: 'Prompt')
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined), 
                                    onPressed: null,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios_outlined), 
                                    onPressed: null,
                                  ),
                                ]
                              )
                            )
                          else if(numPage == 1 && snapshot.data.length > 15)
                            Container(
                              width: screenWidth*0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${word.page['$lang']} : $numPage (1-15 ${word.of['$lang']} ${snapshot.data.length})',
                                    style: TextStyle(fontSize: 16, fontFamily: 'Prompt')
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined), 
                                    onPressed: null,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios_outlined), 
                                    onPressed: (){
                                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, lang, numPage+1)));
                                    }
                                  ),
                                ]
                              )
                            )
                          else if(numPage != 1 && snapshot.data.length > 15 && numPage != maxPage)
                            Container(
                              width: screenWidth*0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${word.page['$lang']} : $numPage ($pagefront-$pageback ${word.of['$lang']} ${snapshot.data.length})',
                                    style: TextStyle(fontSize: 16, fontFamily: 'Prompt')
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined), 
                                    onPressed: (){
                                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, lang, numPage-1)));
                                    }
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios_outlined), 
                                    onPressed: (){
                                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, lang, numPage+1)));
                                    }
                                  ),
                                ]
                              )
                            )
                          else if(numPage == maxPage)
                            Container(
                              width: screenWidth*0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${word.page['$lang']} : $numPage ($pagefront-${snapshot.data.length} ${word.of['$lang']} ${snapshot.data.length})',
                                    style: TextStyle(fontSize: 16, fontFamily: 'Prompt')
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_back_ios_outlined), 
                                    onPressed: (){
                                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, lang, numPage-1)));
                                    }
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios_outlined), 
                                    onPressed: null,
                                  ),
                                ]
                              ),
                            ),
                          Container(
                            width: screenWidth*0.9,
                            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: Color(0xff232d37), //                   <--- border color
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                )
                              ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Table(
                                  border: TableBorder(
                                    verticalInside: BorderSide(width: 1, color: Colors.grey[600], style: BorderStyle.solid),
                                    bottom: BorderSide(color: Colors.grey[600], width: 1)
                                  ),
                                  children: [
                                    TableRow(children: [
                                      headerTableRow('${word.refNo['$lang']}'),
                                      headerTableRow('${word.checkinTime['$lang']}'),
                                      headerTableRow('${word.checkOutTime['$lang']}'),
                                      headerTableRow('${word.status['$lang']}'),
                                    ])
                                  ]
                                ),
                                Table(
                                  border: TableBorder(
                                    verticalInside: BorderSide(width: 1, color: Colors.grey[600], style: BorderStyle.solid),
                                  ),
                                  children: [
                                    if(snapshot.data.length < 15)
                                      for(int i=0;i<snapshot.data.length;i++)
                                        TableRow(
                                          children: [
                                            childTableRow("${snapshot.data[i][0]}"),
                                            childTableRow("${snapshot.data[i][1]}"),
                                            if(snapshot.data[i][2].length > 1)
                                              childTableRow('${snapshot.data[i][2]}')
                                            else
                                              childTableRowIcon(Icons.cancel),
                                            if(snapshot.data[i][3].contains('CheckedIn'))  
                                              childTableRow('${word.statusPending['$lang']}')  
                                            else if (snapshot.data[i][3].toString().contains('CheckedOut'))  
                                              childTableRow('${word.statusSuccess['$lang']}')  
                                          ]
                                        ),  
                                    if(snapshot.data.length > 15)
                                      for(int i=pagefront;i<pageback;i++)
                                        TableRow(
                                          children: [
                                            childTableRow("${snapshot.data[i][0]}"),
                                            childTableRow("${snapshot.data[i][1]}"),
                                            if(snapshot.data[i][2].length > 1)
                                              childTableRow('${snapshot.data[i][2]}')
                                            else
                                              childTableRowIcon(Icons.cancel),
                                            if(snapshot.data[i][3].contains('CheckedIn'))  
                                              childTableRow('${word.statusPending['$lang']}')  
                                            else if (snapshot.data[i][3].toString().contains('CheckedOut'))  
                                              childTableRow('${word.statusSuccess['$lang']}') 
                                          ]
                                        )  
                                  ]
                                ),
                                SizedBox(height: 5),
                                if(checkNotfoundData == true)
                                  Center(
                                    child: Text('${word.notfound['$lang']}', style: TextStyle(fontFamily: 'Prompt')),
                                  ),
                                //clearDataLog(),
                              ]
                            ), 
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    else if(_currentSelection == 1)      // GRAPH DAY
                      Column(
                        children: [
                          Container(
                            width: screenWidth*0.9,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  constraints: BoxConstraints(maxHeight: 45.0),
                                  decoration:  BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                      )
                                    ],
                                    color: colorset.blueOne,
                                  ),
                                  child: Text(
                                    '${word.overviewDay['$lang']} $fullDateDay',
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              freeArea(),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${word.date['$lang']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      textFieldSearch(searchBarController, '${word.chooseDate['$lang']}', screenWidth*0.3, 50.0),
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      buttonDate('2',1),
                                    ],
                                  ),
                                ],
                              ),
                              freeArea(),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              FutureBuilder(
                                future: getDataDayChart(),
                                builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return ChartLogDayWidget(
                                      '${this.dataSearch}', snapshot.data);
                                  } 
                                  else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                              ),
                              SizedBox(height: 15),
                              FutureBuilder(
                                future: getDataDayChartCheckout(),
                                builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return ChartLogDayCheckoutWidget(
                                      '${this.dataSearch}', snapshot.data);
                                  } 
                                  else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                              ),
                            ],
                          ),
                        ],
                      )
                    else if(_currentSelection == 2)      // GRAPH MONTH
                      Column(
                        children: [
                          Container(
                            width: screenWidth*0.9,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  constraints: BoxConstraints(maxHeight: 45.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                      )
                                    ],
                                    color: colorset.blueOne,
                                  ),
                                  child: Text(
                                    '${word.overviewMonth['$lang']} $nameMonthChoose $yearChoose',
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              freeArea(),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${word.month['$lang']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      dropDown(months, '${word.chooseMonth['$lang']}', nameMonthChoose, '3', 2),
                                    ],
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${word.year['$lang']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      dropDown(years, '${word.chooseYear['$lang']}', yearChoose, '3', 2),
                                    ],
                                  ),
                                ],
                              ),
                              freeArea(),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              FutureBuilder(
                                future: getDataMonthChart(),
                                builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    for(int i=0;i<12;i++){
                                      if(monthChoose == (i+1).toString()) {
                                        nameMonth = '${months[i]} $yearChoose';
                                        break;
                                      }
                                    }
                                    return ChartLogMonthWidget(
                                      nameMonth, snapshot.data
                                    );
                                  } 
                                  else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                              ),
                              SizedBox(height: 15),
                              FutureBuilder(
                                future: getDataMonthChartCheckout(),
                                builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    for(int i=0;i<12;i++){
                                      if(monthChoose == (i+1).toString()) {
                                        nameMonth = '${months[i]} $yearChoose';
                                        break;
                                      }
                                    }
                                    return ChartLogMonthCheckoutWidget(
                                      nameMonth, snapshot.data
                                    );
                                  } 
                                  else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                              ),
                            ],
                          ),
                        ],
                      )
                    else if(_currentSelection == 3)      // GRAPH YEAR
                      Column(
                        children: [
                          Container(
                            width: screenWidth*0.9,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  constraints: BoxConstraints(maxHeight: 45.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        spreadRadius: 3,
                                      )
                                    ],
                                    color: colorset.blueOne,
                                  ),
                                  child: Text(
                                    '${word.overviewYear['$lang']} $yearChoose',
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              freeArea(),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${word.year['$lang']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Prompt')),
                                      SizedBox(height: 3),
                                      dropDown(years, '${word.chooseYear['$lang']}',yearChoose, '4', 3),
                                    ],
                                  ),
                                ],
                              ),
                              freeArea(),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              FutureBuilder(
                                future: getDataYearChart(),
                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return ChartLogYearWidget(
                                      yearChoose, numMonthscheckin, numMonthscheckout);
                                  } 
                                  else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          } 
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          } 
        },
      )
    );
  }
///////////////////////////////// Build Widget ///////////////////////////////////////
  Widget headerTableRow(String text){
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Text('$text', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Prompt')),
    );
  }
  Widget childTableRow(String text){
    return Container(
      padding: EdgeInsets.only(top: 6, left: 5, right: 5),
      child: Text('$text', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontFamily: 'Prompt')),
    );
  }
  Widget childTableRowIcon(IconData icon){
    return Container(
      padding: EdgeInsets.only(top: 6, left: 5, right: 5),
      child: Icon(icon, color: Colors.red[700],size: 18)
    );
  }
  Widget buttonDate(String mode, int pageNum){
    return ElevatedButton(
      onPressed: () async {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
        ).then((date){
            List<String> dataSplit1 = date.toIso8601String().split('T');
            List<String> dataSplit2 = dataSplit1[0].split('-');
            yearPick = dataSplit2[0];
            monthPick = dataSplit2[1];
            dayPick = dataSplit2[2];
            var month = dataSplit2[1];
            var day = dataSplit2[2];
            if(dataSplit2[1].startsWith('0')) month = dataSplit2[1].substring(1);
            if(dataSplit2[2].startsWith('0')) day = dataSplit2[2].substring(1);
            if (int.parse(yearPick) < 2022 && (dayPick != '17' && monthPick != '11' && yearPick == '2021')) {
              datePattern = dayPick+'/'+monthPick+'/'+yearPick.substring(2);
            } else {
              datePattern = day+'/'+month+'/'+yearPick;
            }
            if(mode == '2')
              datePattern = datePattern+'_mode2';
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) => Log(datePattern, mode, pageNum, this.lang, 1), 
            ));
        });
      },
      style: TextButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(80.0),
        ),
        backgroundColor: colorset.blueTwo,
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 60, minHeight: 50.0),
        alignment: Alignment.center,
        child: Icon(
          Icons.date_range,
          color: Colors.white,
        ),
      ),  
    );
  }
  Widget buttonShowAll(){
    return ElevatedButton(
      onPressed: () async {
        Navigator.push(context, new MaterialPageRoute(
          builder: (context) => Log(null, '1', 0, this.lang, 1), 
        ));
      },
      style: TextButton.styleFrom(
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(80.0),
        ),
        backgroundColor: colorset.blueTwo,
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: 60, minHeight: 50.0),
        alignment: Alignment.center,
        child: Text(
          '${word.showall['$lang']}',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Prompt',
          ),
        ),
      ),  
    );
  }
  Widget dropDown(List<String> items, String textLabel, String selectItem, String mode, int numPage){
    return Container(
      width: screenWidth*0.30,
      padding: EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: Color(0xff232d37), //                   <--- border color
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 5,
          )
        ]
      ),
      child: DropdownButton<String>(
        hint:  Text('$textLabel', style: TextStyle(fontFamily: 'Prompt')),
        isExpanded: true,
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children:[Icon(Icons.arrow_drop_down)]
        ),
        value: selectItem.isEmpty ? null: selectItem,
        style: TextStyle(
          color: Colors.black
        ),
        underline: Container(
          height: 1.5,
          color: Colors.black
        ),
        onChanged: (item){
          if(textLabel == '${word.chooseYear['$lang']}' && mode == '3'){
            String sendData = item.substring(2)+'spt'+monthChoose;
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) => Log(sendData, mode, numPage, this.lang, 1), 
            ));
          }
          else if(textLabel == '${word.chooseMonth['$lang']}' && mode == '3'){
            String sendData;
            for(int i=0;i<12;i++)
              if(item == months[i]) {
                sendData = this.yearChoose.substring(2)+'spt'+(i+1).toString();
                break;
              }
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) => Log(sendData, mode, numPage, this.lang, 1), 
            ));
          }
          else{
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) => Log(item.substring(2), mode, numPage, this.lang, 1), 
            ));
          }
        },
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
  Widget buildTotal(String members, String date, Color color1, Color color2, String text, double width, String col){
    if(date == null) 
      date = fullDateDay;
    return Container(
      height: 120,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            spreadRadius: 5,
          )
        ]
      ),
      child: Center(
        child: Column(
          children:[
            SizedBox(height: 18.0,),
            Row(
              children: [
                SizedBox(width: 18,),
                Container(
                  height: 35,
                  width: 35,
                  child: Icon(
                    Icons.insert_chart_rounded ,
                    color: Colors.black,
                    size: 25,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black, //                   <--- border color
                      width: 2,
                    ),
                  ),
                ),
                SizedBox(width: 13,),
                Container(
                  child: Text(
                    '$text',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Prompt',
                    ),
                  ),
                ),
              ],
            ),
            if(col == 'col1')
              Column(
                children: [
                  SizedBox(height: 5,),
                  rowInTotalMembers(Icons.supervised_user_circle, 26, 30, 30, members, 30)
                ]
              )
            else if(col == 'col2' || col == 'col3')
              Column(
                children: [
                  SizedBox(height: 5,),
                  rowInTotalMembers(Icons.verified_user, 16, 20, 20, members, 14),
                  SizedBox(height: 8,),
                  rowInTotalDate(date),
                ],
              )   
          ]
        ),
      ),
    );
  }
  Widget rowInTotalMembers(IconData icon, double sizeIcon, double w, double h, String members, double fontSize){
    return Row(
      children: [
        SizedBox(width: 70,),
        Container(
          height: h,
          width: w,
          child: Icon(
            icon,
            size: sizeIcon,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 8,),
        Container(
          child: Text(
            '$members ${word.times['$lang']}',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Prompt',
            ),
          ),
        ),
      ],
    );
  }
  Widget rowInTotalDate(String date){
    return Row(
      children: [
        SizedBox(width: 70,),
        Container(
          height: 20,
          width: 20,
          child: Icon(
            Icons.lock_clock,
            size: 16,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 8,),
        Container(
          child: Text(
            '$date',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Prompt',
            ),
          ),
        ),
      ],
    );
  }
  Future<bool> getDataYearChart() async {
    await users.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        List<String> dataSplit1checkin = doc['checkIn_time'].split('/');
        List<String> dataSplit2checkin = dataSplit1checkin[2].split(' ');
        String dataMonthcheckin = dataSplit1checkin[1];
        if(dataMonthcheckin.startsWith('0'))
          dataMonthcheckin = dataMonthcheckin.substring(1);
        if (dataSplit2checkin[0].length == 2)
          dataSplit2checkin[0] = "20${dataSplit2checkin[0]}";
        if(dataSplit2checkin[0] == yearChoose){
          for(int i=0;i<numMonthscheckin.length;i++){
            if(dataMonthcheckin == (i+1).toString()){
              numMonthscheckin[i] = numMonthscheckin[i] + 1;
              break;
            }
          }
        }
        List<String> dataSplit1checkout = doc['checkOut_time'].split('/');
        if(dataSplit1checkout.length>1){
          List<String> dataSplit2checkout = dataSplit1checkout [2].split(' ');
          String dataMonthcheckout = dataSplit1checkout[1];
          if(dataMonthcheckout.startsWith('0'))
            dataMonthcheckout = dataMonthcheckout.substring(1);
          if (dataSplit2checkout[0].length == 2)
            dataSplit2checkout[0] = "20${dataSplit2checkout[0]}";
          if(dataSplit2checkout[0] == yearChoose){
            for(int i=0;i<numMonthscheckout.length;i++){
              if(dataMonthcheckout == (i+1).toString()){
                numMonthscheckout[i] = numMonthscheckout[i] + 1;
                break;
              }
            }
          }
        }
      })
    });
    return true;
  }
  Future<List<int>> getDataMonthChart() async {
    List<int> numDayscheckin = [];
    for(int i=0;i<31;i++){
      numDayscheckin.add(0);
    }
    await users.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        List<String> dataSplit1checkin = doc['checkIn_time'].split('/');
        List<String> dataSplit2checkin = dataSplit1checkin[2].split(' ');
        if (dataSplit2checkin[0].length == 2)
          dataSplit2checkin[0] = "20${dataSplit2checkin[0]}";
        if(dataSplit1checkin[1].startsWith('0'))
          dataSplit1checkin[1] = dataSplit1checkin[1].substring(1);
        if(dataSplit1checkin[0].startsWith('0'))
          dataSplit1checkin[0] = dataSplit1checkin[0].substring(1);
        if(dataSplit2checkin[0] == yearChoose && dataSplit1checkin[1] == monthChoose){
          for(int i=0;i<31;i++)
            if(dataSplit1checkin[0] == (i+1).toString()){
              numDayscheckin[i] = numDayscheckin[i] + 1;
              break;
            }
        }
      })
    });
    return numDayscheckin;
  }
  Future<List<int>> getDataMonthChartCheckout() async {
    List<int> numDayscheckout = [];
    for(int i=0;i<31;i++){
      numDayscheckout.add(0);
    }
    await users.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        List<String> dataSplit1checkout = doc['checkOut_time'].split('/');
        if(dataSplit1checkout.length>1){
          List<String> dataSplit2checkout = dataSplit1checkout[2].split(' ');
          if (dataSplit2checkout[0].length == 2)
            dataSplit2checkout[0] = "20${dataSplit2checkout[0]}";
          if(dataSplit1checkout[1].startsWith('0'))
            dataSplit1checkout[1] = dataSplit1checkout[1].substring(1);
          if(dataSplit1checkout[0].startsWith('0'))
            dataSplit1checkout[0] = dataSplit1checkout[0].substring(1);
          if(dataSplit2checkout[0] == yearChoose && dataSplit1checkout[1] == monthChoose){
            for(int i=0;i<31;i++)
              if(dataSplit1checkout[0] == (i+1).toString()){
                numDayscheckout[i] = numDayscheckout[i] + 1;
                break;
              }
          }
        }
      })
    });
    return numDayscheckout;
  }
  Future<List<int>> getDataDayChart() async {
    List<int> numTimescheckin = [];
    for(int i=0;i<24;i++){
      numTimescheckin.add(0);
    }
    await users.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        List<String> dataSplit1checkin = doc['checkIn_time'].split('/');
        List<String> dataSplit2checkin = dataSplit1checkin[2].split(' ');
        List<String> dataSplit3checkin = dataSplit2checkin[1].split(':');
        String fullDate = dataSplit1checkin[0]+'/'+dataSplit1checkin[1]+'/'+dataSplit2checkin[0];
        if(dataSplit1checkin[1].startsWith('0')) dataSplit1checkin[1] = dataSplit1checkin[1].substring(1);
        if(dataSplit1checkin[0].startsWith('0')) dataSplit1checkin[0] = dataSplit1checkin[0].substring(1);
        if(dataSplit3checkin[0].startsWith('0')) dataSplit3checkin[0] = dataSplit3checkin[0].substring(1);
        if(fullDate == fullDateDay){
          for(int i=0;i<numTimescheckin.length;i++)
            if(dataSplit3checkin[0] == i.toString()){
              numTimescheckin[i] = numTimescheckin[i] + 1;
              break;
            }
        }  
      })
    });
    return numTimescheckin;
  }
  Future<List<int>> getDataDayChartCheckout() async {
    List<int> numTimescheckout = [];
    for(int i=0;i<24;i++){
      numTimescheckout.add(0);
    }
    await users.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        List<String> dataSplit1checkout = doc['checkOut_time'].split('/');
        if(dataSplit1checkout.length>1){
          List<String> dataSplit2checkout = dataSplit1checkout[2].split(' ');
          List<String> dataSplit3checkout = dataSplit2checkout[1].split(':');
          String fullDate = dataSplit1checkout[0]+'/'+dataSplit1checkout[1]+'/'+dataSplit2checkout[0];
          if(dataSplit1checkout[1].startsWith('0')) dataSplit1checkout[1] = dataSplit1checkout[1].substring(1);
          if(dataSplit1checkout[0].startsWith('0')) dataSplit1checkout[0] = dataSplit1checkout[0].substring(1);
          if(dataSplit3checkout[0].startsWith('0')) dataSplit3checkout[0] = dataSplit3checkout[0].substring(1);
          if(fullDate == fullDateDay){
            for(int i=0;i<numTimescheckout.length;i++)
              if(dataSplit3checkout[0] == i.toString()){
                numTimescheckout[i] = numTimescheckout[i] + 1;
                break;
              }
          }
        }
      })
    });
    return numTimescheckout;
  }
  Future<int> getDataCheck(String check) async {
    int total = 0;
    await users.get().then((QuerySnapshot querySnapshot) => {
      if(check == 'All'){
        querySnapshot.docs.forEach((doc) {
          total = total + 1;
        })
      }
      else if(check == 'TodayCheckin'){
        querySnapshot.docs.forEach((doc) {
          List<String> dataSplit1 = doc['checkIn_time'].split('/');
          List<String> dataSplit2 = dataSplit1[2].split(' ');
          String fullDate = dataSplit1[0]+'/'+dataSplit1[1]+'/'+dataSplit2[0];
          if(dataSearch != null)
            if(fullDate == dataSearch)
              total = total + 1;
          if(dataSearch == null)
            if(fullDate == fullDateDay){
              total = total + 1;
            }
          })
      }
      else if(check == 'TodayCheckout'){
        querySnapshot.docs.forEach((doc) {
          if(doc['status'].toString()=='CheckedOut'){
            List<String> dataSplit1 = doc['checkOut_time'].split('/');
            List<String> dataSplit2 = dataSplit1[2].split(' ');
            String fullDate = dataSplit1[0]+'/'+dataSplit1[1]+'/'+dataSplit2[0];
            if(dataSearch != null)
              if(fullDate == dataSearch)
                total = total + 1;
            if(dataSearch == null)
              if(fullDate == fullDateDay)
                total = total + 1;
          }
        })
      }
    });
    return total;
  }
  Future<List<List<String>>> getDataLog() async {
    List<List<String>> dataLog = [];
    List<String> data4Column = [];
    await users.get().then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((doc) {
        if(dataSearch == null){
          data4Column = [];
          data4Column.add(doc['refNo']);
          data4Column.add(doc['checkIn_time']);
          data4Column.add(doc['checkOut_time']);
          data4Column.add(doc['status']);
          dataLog.add(data4Column);
        }
        else{
          if(doc['checkIn_time'].toString().contains(dataSearch) || doc['checkOut_time'].toString().contains(dataSearch)){
            data4Column = [];
            data4Column.add(doc['refNo']);
            data4Column.add(doc['checkIn_time']);
            data4Column.add(doc['checkOut_time']);
            data4Column.add(doc['status']);
            dataLog.add(data4Column);
          }
        }
      });
    });
    return dataLog;
  }
}