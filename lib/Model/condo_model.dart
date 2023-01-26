import 'package:cloud_firestore/cloud_firestore.dart';

class CondoModel{
  String docId;
  String condoName;
  String condoPromptpay;
  bool condoCollect;
  double condoHour;
  double condoRate;
 
  CondoModel(String condoName, String condoPromptpay, bool condoCollect, double condoHour, double condoRate){
    this.condoName = condoName;
    this.condoPromptpay = condoPromptpay;
    this.condoCollect = condoCollect;
    this.condoHour = condoHour;
    this.condoRate = condoRate;
  }
  CondoModel.updateCondo(String docId, String condoName, String condoPromptpay, bool condoCollect, double condoHour, double condoRate){
    this.docId = docId;
    this.condoName = condoName;
    this.condoPromptpay = condoPromptpay;
    this.condoCollect = condoCollect;
    this.condoHour = condoHour;
    this.condoRate = condoRate;
  }
  CondoModel.docID(String docId) {
    this.docId = docId;
  }

  CollectionReference condo = FirebaseFirestore.instance.collection('ProfileCondo');
  Future<void> addCondo() async {
    condo.add({
      'con_name' : this.condoName,
      'con_promptpay' : this.condoPromptpay,
      'con_collect' : this.condoCollect,
      'con_hour' : this.condoHour,
      'con_rate': this.condoRate, 
    })
    .then((value) => print("Condo Added"))
    .catchError((error) => print("Failed to add Condo: $error"));
  }
  Future<void> updateCondo() async {
    condo.doc(this.docId).update({
      'con_name' : this.condoName,
      'con_promptpay' : this.condoPromptpay,
      'con_collect' : this.condoCollect,
      'con_hour' : this.condoHour,
      'con_rate': this.condoRate, 
    })
    .then((value) => print("Condo Updated"))
    .catchError((error) => print("Failed to update Condo: $error"));
  }
  Future<void> deleteCondo() async {
    condo.doc(this.docId).delete()
    .then((value) => print("User Deleted"))
    .catchError((error) => print("Failed to delete Condo: $error"));
  }
}