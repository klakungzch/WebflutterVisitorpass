import 'package:cloud_firestore/cloud_firestore.dart';

class UserguardModel{
  int id;
  String conName;
  String firstName;
  String lastName;
  String username;
  String pin;
  bool status;
  String docId;
 
  UserguardModel(int id, String conName, String firstName, String lastName, String username, String pin, bool status){
    this.id = id;
    this.conName = conName;
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.pin = pin;
    this.status = status;
  }

  UserguardModel.defaultIDStatus(String docId, String conName, String firstName, String lastName, String username, String pin, bool status){
    this.docId = docId;
    this.conName = conName;
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.pin = pin;
    this.status = status;
  }

  UserguardModel.docID(String docId) {
    this.docId = docId;
  }

  CollectionReference users = FirebaseFirestore.instance.collection('UserGuard');
  Future<void> addUserGuard() async {
    users.add({
      'id' : this.id,
      'condo_name' : this.conName,
      'firstName' : this.firstName,
      'lastName' : this.lastName,
      'username': this.username, 
      'pin': this.pin, 
      'status' : this.status,
    })
    .then((value) => print("User Guard Added"))
    .catchError((error) => print("Failed to add user: $error"));
  }
  Future<void> updateUserGuard() async {
    users.doc(this.docId).update({
      'condo_name' : this.conName,
      'firstName' : this.firstName,
      'lastName' : this.lastName,
      'username': this.username, 
      'pin': this.pin, 
      'status' : this.status,
    })
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
  }
  Future<void> delUserGuard() async {
    users.doc(this.docId).delete()
    .then((value) => print("User Deleted"))
    .catchError((error) => print("Failed to delete user: $error"));
  }
}