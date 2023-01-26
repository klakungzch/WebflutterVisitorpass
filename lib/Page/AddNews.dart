import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as  firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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
  final Future<FirebaseApp> _initialization  = Firebase.initializeApp();
  String imageUrl;
  String defaultImageUrl ="https://learn.g2.com/hubfs/What_is_Information_Technology.jpg";
  String selectFile = "";
  File file;
  String path = "";
  Uint8List selectedImageInBytes;
  FilePickerResult fileResult;

  _selectFile () async{
     fileResult = await FilePicker.platform.pickFiles();

    if(fileResult != null){
      setState(() async {
        selectFile = fileResult.files.single.name;
        path = fileResult.files.single.path;
        selectedImageInBytes = fileResult.files.first.bytes;
        // file = File(fileResult.files.single.path);

      });

      final tempDir = await getTemporaryDirectory();
      file = await new File('${tempDir.path}/'+selectFile+'.jpg').create();
      file.writeAsBytesSync(selectedImageInBytes);
    }

    print(selectFile);
    print(path);

  }
  firebase_storage.UploadTask uploadFile(File file) {
    if (file == null) {
     print("file is  null");
      return null;
    }

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('news')
        .child('/'+selectFile);

    return ref.putFile(file);
  }
  _uploadFile() async{
    try{
      firebase_storage.UploadTask uploadTask;

      final ref = FirebaseStorage.instance
      .ref()
      .child('news')
      .child('/'+selectFile);
     // uploadTask = ref.putFile(File(path));


     // final metadata = firebase_storage.SettableMetadata(contentType: 'image/png');

      //uploadTask = ref.putData(selectedImageInBytes,metadata);
      uploadTask = ref.putFile(file);
      await uploadTask.whenComplete(() => null);
      String imageUrl = await ref.getDownloadURL();
      print ('Uploaded Image URL '+imageUrl);
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var word = new Word();
    var url = new UrlImage();
    var colorset = new ColorSet();

    return FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text("ไม่มีข้อความ"),
              );
            }
            if(snapshot.connectionState == ConnectionState.done) {
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
                            SizedBox(height: 15),
                            Column(
                              children: [selectFile.isEmpty ?
                                  Text("")
                                /*Container(
                                  height: 250,
                                    width: 500,
                                    child: Image.network(defaultImageUrl,fit: BoxFit.contain))*/:
                                Image.memory(selectedImageInBytes,width: 500,height: 250,),
                              ],
                            ),
                            SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: ()  {
                                _selectFile();

                                },
                              child: Text("Upload"),
                            ),
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
                                    var maxId = 1;
                                    querySnapshot.documents.forEach((document) {
                                      var currentValue = document.data()['id'] as double;
                                      if (document.documentID != "") {
                                        count += 1;
                                      }
                                      if (currentValue > maxId) {
                                        maxId = currentValue as int;
                                      }
                                    });
                                    print(count);

                                    var NewsModel = {
                                      "id": maxId+1,
                                      "username": username,
                                      "title" : news_name.text,
                                      "detail" : news_detail.text,
                                      "datetime" : date

                                    };
                                    Firestore.instance
                                        .collection("News")
                                        .document((maxId+1).toString())
                                        .setData(NewsModel);


                                  });

                                  _uploadFile();
                                  uploadFile(file);
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



    );


  }
}