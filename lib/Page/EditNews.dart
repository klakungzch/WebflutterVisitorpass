import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
class EditNews extends StatefulWidget {
  String id;
  String lang;
  EditNews(String id, String lang){
    this.id = id;
    this.lang = lang;
  }
  @override
  _EditNewsState createState() => _EditNewsState(this.id, this.lang);
}
class _EditNewsState extends State<EditNews> {
  String id;
  String lang;
  _EditNewsState(String id, String lang){
    this.id = id;
    this.lang = lang;
  }
  double screenWidth, screenHeight;
  var word = new Word();
  var url = new UrlImage();
  var colorset = new ColorSet();
  CollectionReference news = FirebaseFirestore.instance.collection('News');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var title = new TextEditingController();
    var news_detail = new TextEditingController();

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
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => EditNews(this.id, 'TH')));
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
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => EditNews(this.id, 'EN')));
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
      body: FutureBuilder<DocumentSnapshot>(
        future: news.doc(this.id).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
          title.text = snapshot.data['title'];
          news_detail.text = snapshot.data['detail'];
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: screenWidth*0.7,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    topUserEdit(context, '${word.editNewsHeader['$lang']} : ${snapshot.data['title']}'),
                    SizedBox(height: 15),
                    textFieldnews(context, title, Icon(Icons.newspaper), '${word.newsName['$lang']}', false),
                    margin(context),
                    textFieldnewsDetail(context, news_detail, Icon(Icons.newspaper), '${word.newDetail['$lang']}', false),
                    SizedBox(height: 15),
                    margin(context),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        if(title.text.isEmpty || news_detail.text.isEmpty ){
                          dialogCustom(context, '${word.dialogAdduserHeader1['$lang']}', this.lang);                      
                        }
                        else{
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
                                            '${word.dialogEditNewsHeader1['$lang']}',
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
                                        child: Text('${word.dialogEditNewsDetail1_1['$lang']} ${snapshot.data['title']}${word.dialogEditNewsDetail1_2['$lang']}', style: TextStyle(color: Colors.white, fontFamily: 'Prompt'), textAlign: TextAlign.center),
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
                                            onPressed: () async {
                                              print('id : ${this.id}');
                                              var model;
                                              final DateTime now = DateTime.now();

                                              String date = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString()+" "+now.hour.toString()+":"+now.minute.toString();

                                                model = NewsModel.updateNews(this.id,title.text,news_detail.text,date);
                                              await model.updateNews();
                                              Navigator.push(context,  MaterialPageRoute(builder: (context) => NewsManagement(null, this.lang)));
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
                                fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
  Widget topUserEdit(BuildContext context, String userEdit){
    return Container(
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
              userEdit,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
            ),
          ),
        ],
      ),
    );    
  }
}