import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel{
  String id;
  String username;
  String title;
  String detail;
  String datetime;

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
  NewsModel.updateNews(String id,
      String title,
      String detail,
      String datetime){
    this.id = id;
    this.title = title;
    this.detail = detail;
    this.datetime = datetime;
  }
  NewsModel.newID(String id) {
    this.id = id;
  }

  CollectionReference news = FirebaseFirestore.instance.collection('News');
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
  }
}