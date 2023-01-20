import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitorguard/Language/UrlImage.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Model/condo_model.dart';
import 'package:visitorguard/Page/CondoManagement.dart';
import 'package:visitorguard/Page/Log.dart';
import 'package:visitorguard/Widgets/ColorSet.dart';
import 'package:visitorguard/Widgets/Margin.dart';
import 'package:visitorguard/Widgets/ShowAlertDialog.dart';
import 'package:visitorguard/Widgets/TextField.dart';

import '../Model/news_model.dart';
import 'NewsManagement.dart';

// ignore: must_be_immutable
class AddNews extends StatefulWidget {
  String lang;
  AddNews(String lang){
    this.lang = lang;
  }
  @override
  _AddNewsState createState() => _AddNewsState(this.lang);
}
class _AddNewsState extends State<AddNews> {
  String lang;
  String id;
  _AddNewsState(String lang){
    this.lang = lang;
  }
  double screenWidth, screenHeight;
  var news_name = new TextEditingController();
  var news_detail= new TextEditingController();
 /* var userName ;
  CollectionReference users = FirebaseFirestore.instance.collection('UserGuard');

  @override
  void initState() {
    users.doc(this.id).get().then((value) {
      userName = value.data()['username'];
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var word = new Word();
    var url = new UrlImage();
    var colorset = new ColorSet();
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
                    fontFamily: 'Prompt',
                    color: Colors.white
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => AddNews('TH')));
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => AddNews('EN')));
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: screenWidth*0.7,
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child :Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        constraints: BoxConstraints(maxHeight: 45.0, maxWidth: 500),
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
                          '${word.newsHeader['$lang']}',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),  
                SizedBox(height: 15),
                textFieldnews(context, news_name, Icon(Icons.newspaper), '${word.newsName['$lang']}', false),
                SizedBox(height: 15),
                Container(
                  child: TextField(
                    controller: news_detail,
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                    maxLength: 1000,
                    decoration: InputDecoration(
                      labelText: '${word.newDetail['$lang']}',
                      prefixIcon: Icon(Icons.newspaper),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.amber,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                ),
                margin(context),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    if(news_name.text.isEmpty || news_detail.text.isEmpty ){
                      dialogCustom(context, '${word.dialogAdduserHeader1['$lang']}', this.lang);
                    }
                    else{
                      var model;
                      final DateTime now = DateTime.now();
                      final prefs = await SharedPreferences.getInstance();
                      String username = prefs.getString("userlogin");
                      String date = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString()+" "+now.hour.toString()+":"+now.minute.toString();


                      Firestore.instance.collection("News").getDocuments().then((querySnapshot) {
                        int count = 1;
                        querySnapshot.documents.forEach((document) {
                          if (document.documentID != "") {
                            count += 1;
                          }
                        });
                        print(count);
                        var NewsModel = {
                          "id": count,
                          "username": username,
                          "title" : news_name.text,
                          "detail" : news_detail.text,
                          "datetime" : date

                        };
                        Firestore.instance
                            .collection("News")
                            .document(count.toString())
                            .setData(NewsModel);
                      });
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => NewsManagement(null, this.lang)));
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(80.0),
                    ),
                    padding: EdgeInsets.all(0.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(30.0)
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: screenWidth*0.35, minHeight: 45.0),
                      alignment: Alignment.center,
                      child: Text(
                        "${word.confirm['$lang']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Prompt'
                        ),
                      ),
                    ),
                  ),
                ),
                margin(context),
              ],
            ),
          ),
        ),
      )
    );
  }
}