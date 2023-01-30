import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as  firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  List<String> imageUrls = [];
  String defaultImageUrl ="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv_OkZlKYDhVdfNIQ5-VURqB3TyNrIBxQqcSSMwm7P7IdQZFgvXq05r1YmG9rr-XJLPf0&usqp=CAU";
  String selectFile = "";
  XFile file;
  String path = "";
  Uint8List selectedImageInBytes;
  List<Uint8List> selectedImageList = [];
  int itemcount  = 0;
  bool isItemSaved = false;

  _selectFile () async{
    FilePickerResult fileResult = await FilePicker.platform.pickFiles();

    if(fileResult != null){
      setState(()  {
        selectFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes;
      });
    }
    print(selectFile);
  }
  _selectFilemultiple () async{
    FilePickerResult fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);

    if(fileResult != null && fileResult.files.length < 4){
      selectFile = fileResult.files.first.name;
      fileResult.files.forEach((element) {
        setState(()  {
          selectedImageList.add(element.bytes);
          itemcount += 1;
        });
      });

    }
    print(selectFile);
  }


  _uploadFile(int maxid) async{
    try{
      firebase_storage.UploadTask uploadTask;

      final ref = FirebaseStorage.instance
          .ref()
          .child('news')
          .child('/'+maxid.toString()+"-"+news_name.text);
      // uploadTask = ref.putFile(File(path));


       final metadata = firebase_storage.SettableMetadata(contentType: 'image/png');

      uploadTask = ref.putData(selectedImageInBytes,metadata);
     // uploadTask = ref.putFile(file);
      await uploadTask.whenComplete(() => null);
      String imageUrl = await ref.getDownloadURL();
      print ('Uploaded Image URL '+imageUrl);
    }catch(e){
      print(e);
    }
  }


   Future<String> _uploadMultipleFiles(String itemName) async {
    String imageUrl = '';
    try {
      for (var i = 0; i < itemcount; i++) {
        firebase_storage.UploadTask uploadTask;

        final ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('news')
            .child('/' + itemName + '/' + i.toString());

        final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/png');

        //uploadTask = ref.putFile(File(file.path));
        uploadTask = ref.putData(selectedImageList[i], metadata);

        await uploadTask.whenComplete(() => null);
        imageUrl = await ref.getDownloadURL();
        setState(() {
          imageUrls.add(imageUrl);
          print ('Uploaded Image URL '+imageUrl);
        });
      }
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var word = new Word();
    var url = new UrlImage();
    var colorset = new ColorSet();

    return _initialization ==null ? Container():  FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(!snapshot.hasData) {
            // show loading while waiting for real data
            return CircularProgressIndicator();
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
                          Container(
                            child:  selectFile.isEmpty
                                ? Image.network(
                              defaultImageUrl,
                              fit: BoxFit.cover,
                            )
                            // Image.asset('assets/create_menu_default.png')
                                : Container(height: MediaQuery.of(context).size.height * 0.45,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                              ),
                              child: CarouselSlider(
                                options: CarouselOptions(height: 400.0,viewportFraction: 1.0,
                                    enlargeCenterPage: false),
                                items: selectedImageList.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Image.memory(i),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
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
                          ElevatedButton(
                            onPressed: ()  {
                              //_selectFile();
                              _selectFilemultiple();
                            },
                            child: Text('${word.choosenews['$lang']}'),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: ()  {
                              setState(()   {
                                selectedImageList.clear();
                               /* Uint8List bytes = (await NetworkAssetBundle(Uri.parse(defaultImageUrl))
                                    .load(defaultImageUrl))
                                    .buffer
                                    .asUint8List();
                                selectedImageList.add(bytes); */
                                print('You Clear image');
                              });
                            },
                            child: Text('${word.clearimage['$lang']}'),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () async {
                              if(news_name.text.isEmpty || news_detail.text.isEmpty ){
                                dialogCustom(context, '${word.dialogAdduserHeader1['$lang']}', this.lang);
                              }else if(selectedImageList == []  || selectedImageList.isEmpty){
                                dialogCustom(context, '${word.dialogAddnewsHeader1['$lang']}', this.lang);
                              }
                              else{
                                var model;
                                final DateTime now = DateTime.now();
                                final prefs = await SharedPreferences.getInstance();
                                String username = prefs.getString("userlogin");
                                String date = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString()+" "+now.hour.toString()+":"+now.minute.toString();

                                FirebaseFirestore.instance.collection("News").get().then((querySnapshot) async {
                                  int count = 1;
                                  var maxId = 0;
                                  querySnapshot.docs.forEach((document) {
                                    var currentValue = document.data()['id'] as double;
                                    if (document.data() != "") {
                                      count += 1;
                                    }
                                    if (currentValue > maxId) {
                                      maxId = currentValue as int;
                                    }
                                  });
                                  print(count);
                                  int mid = maxId +1;
                                  await _uploadMultipleFiles(mid.toString());
                                  var NewsModel2 = {
                                    "id": maxId+1,
                                    "username": username,
                                    "title" : news_name.text,
                                    "detail" : news_detail.text,
                                    "datetime" : date,
                                    "imageurl" : imageUrls

                                  };
                                  FirebaseFirestore.instance
                                      .collection("News")
                                      .doc((maxId+1).toString())
                                      .set(NewsModel2);

                                  //_uploadFile(maxId+1);


                                  //saveItem();
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



    );


  }
}