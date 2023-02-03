import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visitorguard/Language/UrlImage.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Model/condo_model.dart';
import 'package:visitorguard/Page/CondoManagement.dart';

import 'package:firebase_storage/firebase_storage.dart' as  firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
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
  List<String> imageUrls = [];
  String defaultImageUrl ="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQv_OkZlKYDhVdfNIQ5-VURqB3TyNrIBxQqcSSMwm7P7IdQZFgvXq05r1YmG9rr-XJLPf0&usqp=CAU";
  String selectFile = "";
  XFile file;
  String path = "";
  Uint8List selectedImageInBytes;
  List<Uint8List> selectedImageList = [];
  int itemcount  = 0;
  bool isItemSaved = false;
  var title = new TextEditingController();
  var news_detail = new TextEditingController();
  String tilestr ="";
  String news_detailstr = "";
  bool status = false;
  int Actionindex = 0;
  CarouselController buttonCarouselController = CarouselController();
  bool isLoading = false;

  _selectFilemultiple () async{
    FilePickerResult fileResult = await FilePicker.platform.pickFiles(allowMultiple: true);

    if(fileResult != null && fileResult.files.length < 4){
      selectFile = fileResult.files.first.name;
      fileResult.files.forEach((element) {
        setState(()  {
          if(selectedImageList.length < 3){
            selectedImageList.add(element.bytes);
            itemcount += 1;
            tilestr = title.text;
            news_detailstr = news_detail.text;
            status =true ;
          }else{
            dialogCustom(context, '${word.dialogAddnewsHeader1['$lang']}', this.lang);
          }
        });
      });

    }else{
      dialogCustom(context, '${word.dialogAddnewsHeader1['$lang']}', this.lang);
    }
    print(selectFile);
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
          if (status == true){
            title.text = tilestr;
            news_detail.text = news_detailstr;

          }else{
            title.text = snapshot.data['title'];
            news_detail.text = snapshot.data['detail'];
          }

          List<dynamic> uriimage = snapshot.data['imageurl'];

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
                    Container(
                      child:  selectFile.isEmpty
                          ?
                      CarouselSlider(
                        items: uriimage.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.network(i) ,
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 400.0,
                          autoPlay: true,
                            pageSnapping: false,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            autoPlayInterval: Duration(seconds: 2),
                            initialPage: 0,
                         /* onPageChanged: (index,reason) {
                            setState(() {
                              Actionindex = index;
                            });
                          },*/
                        ),
                      )

                      // Image.asset('assets/create_menu_default.png')
                          : CarouselSlider(
                            carouselController: buttonCarouselController,
                            options: CarouselOptions(
                              height: 400.0,
                              pageSnapping: false,
                              autoPlay: true,
                              enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              autoPlayInterval: Duration(seconds: 2),
                              initialPage: 0,
                             /* onPageChanged: (index,reason) {
                                setState(() {
                                  Actionindex = index;
                                });

                              },*/
                            ),
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

                    SizedBox(height: 15),
                    textFieldnews(context, title, Icon(Icons.newspaper), '${word.newsName['$lang']}', false),
                    margin(context),
                    textFieldnewsDetail(context, news_detail, Icon(Icons.newspaper), '${word.newDetail['$lang']}', false),
                    SizedBox(height: 15),
                    margin(context),
                    ElevatedButton(
                      onPressed: ()  {
                        //_selectFile();
                        _selectFilemultiple();
                      },
                      child: Text('${word.choosenews['$lang']}'),
                    ),
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
                                        child: Text('${word.dialogEditNewsDetail1_1['$lang']}', style: TextStyle(color: Colors.white, fontFamily: 'Prompt'), textAlign: TextAlign.center),
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
                                              if(title.text.isEmpty || news_detail.text.isEmpty || title.text == "" || title.text == " "){
                                                dialogCustom(context, '${word.dialogAdduserHeader1['$lang']}', this.lang);
                                              }else if(selectedImageList == []  || selectedImageList.isEmpty){
                                                print('id : ${this.id}');
                                                var model;
                                                final DateTime now = DateTime.now();
                                                final prefs = await SharedPreferences.getInstance();
                                                String username = prefs.getString("userlogin");
                                                String date = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString()+" "+now.hour.toString()+":"+now.minute.toString();

                                                FirebaseFirestore.instance.collection("News").get().then((querySnapshot) async {
                                                  await _uploadMultipleFiles(this.id);
                                                  var NewsModel2 = {
                                                    "id": int.parse(this.id),
                                                    "username": username,
                                                    "title" : title.text,
                                                    "detail" : news_detail.text,
                                                    "datetime" : date,
                                                    "imageurl" : uriimage

                                                  };
                                                  FirebaseFirestore.instance
                                                      .collection("News")
                                                      .doc((this.id).toString())
                                                      .set(NewsModel2);
                                                });
                                                Navigator.push(context,  MaterialPageRoute(builder: (context) => NewsManagement(null, this.lang)));

                                              }
                                              else{
                                                print('id : ${this.id}');
                                                var model;
                                                final DateTime now = DateTime.now();
                                                final prefs = await SharedPreferences.getInstance();
                                                String username = prefs.getString("userlogin");
                                                String date = now.day.toString()+"/"+now.month.toString()+"/"+now.year.toString()+" "+now.hour.toString()+":"+now.minute.toString();


                                                FirebaseFirestore.instance.collection("News").get().then((querySnapshot) async {
                                                  await _uploadMultipleFiles(this.id);
                                                  var NewsModel2 = {
                                                    "id": int.parse(this.id),
                                                    "username": username,
                                                    "title" : title.text,
                                                    "detail" : news_detail.text,
                                                    "datetime" : date,
                                                    "imageurl" : imageUrls

                                                  };
                                                  FirebaseFirestore.instance
                                                      .collection("News")
                                                      .doc((this.id).toString())
                                                      .set(NewsModel2);

                                                  //_uploadFile(maxId+1);


                                                  //saveItem();
                                                });



                                              Navigator.push(context,  MaterialPageRoute(builder: (context) => NewsManagement(null, this.lang)));
                                              }
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