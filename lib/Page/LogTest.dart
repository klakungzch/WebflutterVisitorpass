import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitorguard/Language/UrlImage.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Widgets/ColorSet.dart';
import 'package:visitorguard/Widgets/Margin.dart';
import 'package:visitorguard/Widgets/TextField.dart';

// ignore: must_be_immutable
class LogTest extends StatefulWidget {
  String dataSearch;
  String lang;
  int numPage;
  LogTest(String dataSearch, String lang, int numPage){
    this.dataSearch = dataSearch;
    this.lang = lang;
    this.numPage = numPage;
  }
  @override
  _LogTestState createState() => _LogTestState(this.dataSearch, this.lang, this.numPage);
}

class _LogTestState extends State<LogTest> {
  String dataSearch;
  String lang;
  int numPage;
  _LogTestState(String dataSearch, String lang, int numPage){
    this.dataSearch = dataSearch;
    this.lang = lang;
    this.numPage = numPage;
  }

  @override
  initState(){ 
    super.initState();
  }

  var word = new Word(); // class of language words
  var url = new UrlImage(); // class of url Image
  var colorset = new ColorSet(); // class of main color 
  bool checkNotfoundData = true;
  
  double screenWidth, screenHeight;
  Query users = FirebaseFirestore.instance.collection('saveLog').orderBy('id', descending: true);
  TextEditingController searchBarController = TextEditingController();
 
  String dateNow = DateTime.now().toIso8601String();
  String dayNow, monthNow, yearNow;
  String monthChoose, yearChoose, dayChoose;
  String fullDateDay;
  String dayPick, monthPick ,yearPick;
  String datePattern;

  Future<List<List<String>>> getDataLog() async {
    List<List<String>> dataLog = [];
    List<String> data4Column = [];
    await users.get().then((QuerySnapshot querySnapshot){
      querySnapshot.docs.forEach((doc) {
        if(dataSearch == null){
          data4Column = [];
          data4Column.add(doc.data()['refNo']);
          data4Column.add(doc.data()['checkIn_time']);
          data4Column.add(doc.data()['checkOut_time']);
          data4Column.add(doc.data()['status']);
          dataLog.add(data4Column);
        }
        else{
          if(doc.data()['checkIn_time'].toString().contains(dataSearch) || doc.data()['checkOut_time'].toString().contains(dataSearch)){
            data4Column = [];
            data4Column.add(doc.data()['refNo']);
            data4Column.add(doc.data()['checkIn_time']);
            data4Column.add(doc.data()['checkOut_time']);
            data4Column.add(doc.data()['status']);
            dataLog.add(data4Column);
          }
        }
      });
    });
    print(dataLog);
    return dataLog;
  }
  Widget build(BuildContext context) {
    List<String> split1 = dateNow.split('T');
    List<String> split2 = split1[0].split('-');
    yearNow = split2[0];
    yearNow = yearNow.substring(2);
    monthNow = split2[1];
    dayNow = split2[2];

    yearChoose = yearNow;
    monthChoose = monthNow;
    dayChoose = dayNow;
    fullDateDay = dayNow+'/'+monthNow+'/'+yearNow; // Date now

    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    int pagefront;
    int pageback;
    int maxPage;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(
                'Vistor - Guard',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Prompt',
                ),
              ),
              onPressed: (){
                Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, lang, 1)));
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, 'TH', 1)));
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, 'EN', 1)));
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
      body: FutureBuilder(
        future: getDataLog(),
        builder: (BuildContext context, AsyncSnapshot<List<List<String>>> snapshot) {
          if(snapshot.hasError){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done){
            if(dataSearch != null)
              for(int i=0;i<snapshot.data.length;i++){
                if(snapshot.data[i].contains(dataSearch) || snapshot.data[i].contains(dataSearch)){
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
            print('refno length:${snapshot.data.length}');
            
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                child: Column(
                  children: [
                    // ALL LOG
                    Column(
                      children: [
                        // Header
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
                        // Row Searchbar
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
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, lang, numPage+1)));
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
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, lang, numPage-1)));
                                  }
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_outlined), 
                                  onPressed: (){
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, lang, numPage+1)));
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
                                    Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, lang, numPage-1)));
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
                                )
                            ]
                          ),
                        ),
                      ],
                    )
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
            yearPick = dataSplit2[0].substring(2);
            monthPick = dataSplit2[1];
            dayPick = dataSplit2[2];
            datePattern = dayPick+'/'+monthPick+'/'+yearPick;
            print(datePattern);
            if(mode == '2')
              datePattern = datePattern+'_mode2';
            Navigator.push(context, new MaterialPageRoute(
              builder: (context) => LogTest(datePattern, this.lang, 1), 
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
          builder: (context) => LogTest(null, this.lang, 1), 
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
}