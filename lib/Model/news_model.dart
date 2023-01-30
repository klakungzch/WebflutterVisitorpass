import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as  firebase_storage;
class NewsModel{
  String id;
  String username;
  String title;
  String detail;
  String datetime;
  String imageurl;


  NewsModel(String id,
  String username,
  String title,
  String detail,
  String datetime){
    this.username = username;
    this.title = title;
    this.detail = detail;
    this.datetime = datetime;
  }
  NewsModel2(String id,
      String username,
      String title,
      String detail,
      String datetime,
      String imageurl){
    this.username = username;
    this.title = title;
    this.detail = detail;
    this.datetime = datetime;
    this.imageurl = imageurl;

  }
  NewsModel3(String id,
      String title,
      String detail,
      String datetime,
      String imageurl){
    this.title = title;
    this.detail = detail;
    this.datetime = datetime;
    this.imageurl = imageurl;

  }
  NewsModel.updateNews(String id,
      String title,
      String detail,
      String datetime,String imageurl){
    this.id = id;
    this.title = title;
    this.detail = detail;
    this.datetime = datetime;
    this.imageurl = imageurl;

  }
  NewsModel.newID(String id) {
    this.id = id;
  }

  CollectionReference news = FirebaseFirestore.instance.collection('News');


  final storageReferance =  FirebaseStorage.instance.ref();

  Future<void> addNews() async {
    news.add({
      'id' : this.id,
      'username' : this.username,
      'title' : this.title,
      'detail' : this.detail,
      'datetime': this.datetime,
    })
        .then((value) => print("News Added"))
        .catchError((error) => print("Failed to add News: $error"));
  }
  Future<void> updateNews() async {
    news.doc(this.id).update({
      'title' : this.title,
      'detail' : this.detail,
      'datetime': this.datetime,
    })
        .then((value) => print("News Updated"))
        .catchError((error) => print("Failed to update News: $error"));
  }
  Future<void> deleteNews() async {
    news.doc(this.id).delete()
        .then((value) => print("News Deleted"))
        .catchError((error) => print("Failed to delete News: $error"));

    ListResult list = await FirebaseStorage.instance.ref().child('news').child('/'+this.id).listAll();
    List<Reference> items = list.items;
    List<String> paths = [];
    for (Reference item in items) {
      paths.add(item.fullPath);
      print(paths.toString());
    }

    for(String path in paths){
      storageReferance
          .child(path)
          .delete()
          .then((_) => print('Successfully deleted $id storage item'));
    }
  }

}