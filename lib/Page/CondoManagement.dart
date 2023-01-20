import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitorguard/Language/UrlImage.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Model/condo_model.dart';
import 'package:visitorguard/Page/AddProfileCondo.dart';
import 'package:visitorguard/Page/EditCondo.dart';
import 'package:visitorguard/Page/Log.dart';
import 'package:visitorguard/Widgets/ColorSet.dart';
import 'package:visitorguard/Widgets/Drawer.dart';
import 'package:visitorguard/Widgets/Margin.dart';
import 'package:visitorguard/Widgets/TextField.dart';

// ignore: must_be_immutable
class CondoManagement extends StatefulWidget {
  String textToSearch;
  String lang;
  CondoManagement(String textToSearch, String lang){
    this.textToSearch = textToSearch;
    this.lang = lang;
  }
  @override
  _CondoManagementState createState() => _CondoManagementState(this.textToSearch, this.lang);
}

class _CondoManagementState extends State<CondoManagement> {
  String textToSearch;
  String lang;
  _CondoManagementState(String textToSearch, String lang){
    this.textToSearch = textToSearch;
    this.lang = lang;
  }

  @override
  void initState() {
    super.initState();
  }

  var word = new Word();
  var url = new UrlImage();
  var colorset = new ColorSet();
  bool checkNotfoundData = true;
  int numTrueBar = 0, numFalseBar = 0 ,numTruePie = 0, numFalsePie = 0;
  double screenWidth, screenHeight;
  Query condo = FirebaseFirestore.instance.collection('ProfileCondo');
  TextEditingController searchBarController = TextEditingController();

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    searchBarController.text = textToSearch;
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => CondoManagement(null, 'TH')));
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => CondoManagement(null, 'EN')));
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
      body: StreamBuilder<QuerySnapshot>(
        stream:  condo.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          numTrueBar = 0; numFalseBar = 0; numTruePie = 0; numFalsePie = 0;
          checkNotfoundData = true;
          return new SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                child: Column(
                  children: [
                    Container(
                      width: screenWidth*0.9,
                      child: Column(
                        children: [
                          if(screenWidth>515)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                    '${word.condoHeader['$lang']}',
                                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 15),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) => AddProfileCondo(this.lang),
                                    ));
                                  },
                                  style: TextButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(80.0),
                                    ),
                                    backgroundColor: colorset.blueTwo,
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(minHeight: 35.0),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          '${word.addCondo['$lang']}',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]
                            )
                          else
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        '${word.condoHeader['$lang']}',
                                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                      ),
                                    ),
                                  ]
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.push(context, new MaterialPageRoute(
                                          builder: (context) => AddProfileCondo(this.lang),
                                        ));
                                      },
                                      style: TextButton.styleFrom(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(80.0),
                                        ),
                                        backgroundColor: colorset.blueTwo,
                                      ),
                                      child: Container(
                                        constraints: BoxConstraints(minHeight: 35.0),
                                        alignment: Alignment.center,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_circle,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              '${word.addCondo['$lang']}',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                                )
                              ],
                            ),
                        ],
                      )
                    ),

                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        freeArea(),
                        Row(
                          children: [
                            textFieldSearchTrue(searchBarController, '${word.searchBycondoName['$lang']}', screenWidth*0.5, 50.0),
                            SizedBox(width: 10,),
                            buttonSearch(),
                            SizedBox(width: 10,),
                            buttonShowAll(),
                          ],
                        ),
                        freeArea(),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: snapshot.data.docs.map((DocumentSnapshot document) {
                            if(textToSearch == null || textToSearch == ''){
                              checkNotfoundData = false;
                              return listProfileCondo(document);
                            }
                            else if(document.data()['con_name'].toString().contains(textToSearch)){
                              checkNotfoundData = false;
                              return listProfileCondo(document);
                            }
                            else{
                              return SizedBox(height: 0, width: 0);
                            }
                          }).toList(),
                        ),
                        SizedBox(height: 15),
                        if(checkNotfoundData == true)
                          Center(
                            child: Text('${word.notfound['$lang']}', style: TextStyle(fontFamily: 'Prompt')),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
          );
        },
      )
    );
  }
////////////////////////////////////////////////////////////////// Build Widget //////////////////////////////////////////////////////////////////
  Widget listProfileCondo(DocumentSnapshot document){
    return Container(
      width: screenWidth*0.9,
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(width: 1, color: Color.fromARGB(255, 191, 191, 191))
        ),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Color.fromARGB(255, 191, 191, 191)))),
            child: Icon(Icons.home_outlined, color: colorset.blueTwo, size: 40), // Hardcoded to be 'x'
          ),
          title: Wrap(
            spacing: 5,
            children: [
              new Text('${word.condoName['$lang']} : ${document.data()['con_name']}' ,style: (TextStyle(fontFamily: 'Prompt'))),
            ],
          ),
          subtitle: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  '${word.promptpay['$lang']} : ${document.data()['con_promptpay']}',
                  style: TextStyle(fontFamily: 'Prompt')),
              if (document.data()['con_rate'] == 0)
                ( //check if there are Collect fee ?
                    Text('${word.noFee['$lang']}', style: TextStyle(fontFamily: 'Prompt')))
              else if (document.data()['con_hour'] != 0 &&
                  document.data()['con_rate'] != 0)
                (Text(
                    '${word.rate['$lang']} : ${document.data()['con_rate']} ${word.perhour['$lang']}, ${word.startCollect['$lang']} ${document.data()['con_hour']} ${word.hour['$lang']}',
                    style: TextStyle(fontFamily: 'Prompt')))
              else if (document.data()['con_rate'] != 0 &&
                    document.data()['con_hour'] == 0)
                  (Text(
                      '${word.rate['$lang']} : ${document.data()['con_rate']} ${word.perhour['$lang']}',
                      style: TextStyle(fontFamily: 'Prompt')))
            ],
          ),
          trailing: Wrap(
            spacing: 12,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                tooltip: '${word.editCondo['$lang']} : ${document.data()['con_name']}',
                onPressed: (){
                  Navigator.push(context,  MaterialPageRoute(builder: (context) => EditCondo(document.id, this.lang)));
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                tooltip: '${word.deleteCondo['$lang']} : ${document.data()['con_name']}',
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 300.0, maxHeight: 200),
                          padding: EdgeInsets.only(bottom: 20,),
                          decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    '${word.dialogCondoHeader1['$lang']}',
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Prompt'),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16, left: 16),
                                child: Text('${word.dialogCondoDetail1_1['$lang']} ${document.data()['con_name']}${word.dialogCondoDetail1_2['$lang']}', style: TextStyle(color: Colors.white, fontFamily: 'Prompt'), textAlign: TextAlign.center,),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('${word.cancel['$lang']}'),
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      textStyle: TextStyle(fontFamily: 'Prompt'),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  ElevatedButton(
                                    onPressed: (){
                                      var model = CondoModel.docID(document.id);
                                      model.deleteCondo();
                                      Navigator.of(context).pop();
                                      Navigator.push(context,  MaterialPageRoute(builder: (context) => CondoManagement(null, this.lang)));
                                    },
                                    child: Text('${word.ok['$lang']}'),
                                    style: TextButton.styleFrom(
                                      primary: Colors.yellow[700],
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(fontFamily: 'Prompt'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buttonSearch(){
    return ElevatedButton(
      onPressed: () async {
        Navigator.push(context, new MaterialPageRoute(
          builder: (context) => CondoManagement(searchBarController.text, this.lang),
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
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
  Widget buttonShowAll(){
    return ElevatedButton(
      onPressed: () async {
        Navigator.push(context, new MaterialPageRoute(
          builder: (context) => CondoManagement(null, this.lang),
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

