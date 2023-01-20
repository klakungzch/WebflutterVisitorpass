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
// ignore: must_be_immutable
class EditCondo extends StatefulWidget {
  String id;
  String lang;
  EditCondo(String id, String lang){
    this.id = id;
    this.lang = lang;
  }
  @override
  _EditCondoState createState() => _EditCondoState(this.id, this.lang);
}
class _EditCondoState extends State<EditCondo> {
  String id;
  String lang;
  _EditCondoState(String id, String lang){
    this.id = id;
    this.lang = lang;
  }
  double screenWidth, screenHeight;
  var word = new Word();
  var url = new UrlImage();
  var colorset = new ColorSet();
  var con_collect;
  CollectionReference condo = FirebaseFirestore.instance.collection('ProfileCondo');

  @override
  void initState(){
    condo.doc(this.id).get().then((value) {
      con_collect = value.data()['con_collect'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var con_name = new TextEditingController();
    var con_promptpay = new TextEditingController();
    var con_hour = new TextEditingController();
    var con_rate = new TextEditingController();
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
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => EditCondo(this.id, 'TH')));
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
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => EditCondo(this.id, 'EN')));
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
        future: condo.doc(this.id).get(),
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
          con_name.text = snapshot.data.data()['con_name'];
          con_promptpay.text = snapshot.data.data()['con_promptpay'];
          con_hour.text = snapshot.data.data()['con_hour'].toString();
          con_rate.text = snapshot.data.data()['con_rate'].toString();
          if(!con_collect || con_collect && con_rate.text == '0') {
            con_hour.text = '';
            con_rate.text = '';
          }
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: screenWidth*0.7,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    topUserEdit(context, '${word.editCondoHeader['$lang']} : ${snapshot.data.data()['con_name']}'),
                    SizedBox(height: 15),
                    textField(context, con_name, Icon(Icons.person), '${word.condoName['$lang']}', false),  
                    margin(context),
                    textField(context, con_promptpay, Icon(Icons.person_add_alt_1), '${word.promptpay['$lang']}', false),
                    margin(context),
                    SizedBox(height: 15),
                    CheckboxListTile(
                      title: Text('${word.collect['$lang']}'),
                      value: con_collect,
                      onChanged: (newCollect) {
                        setState(() {
                          con_collect = newCollect;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: TextField(
                        enabled: con_collect,
                        controller: con_rate,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                        maxLength: 3,
                        decoration: InputDecoration(
                          labelText: '${word.rate['$lang']}',
                          prefixIcon: Icon(Icons.supervised_user_circle),
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
                    Container(
                      child: TextField(
                        enabled: con_collect,
                        controller: con_hour,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16),
                        maxLength: 2,
                        decoration: InputDecoration(
                          labelText: '${word.startHour['$lang']}',
                          prefixIcon: Icon(Icons.access_time),
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
                        if(con_name.text.isEmpty || con_promptpay.text.isEmpty || (con_collect && (con_rate.text == '0' || con_rate.text == '00' || con_rate.text == '000' || con_rate.text.isEmpty))){
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
                                            '${word.dialogEditCondoHeader1['$lang']}', 
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
                                        child: Text('${word.dialogEditCondoDetail1_1['$lang']} ${snapshot.data.data()['con_name']}${word.dialogEditCondoDetail1_2['$lang']}', style: TextStyle(color: Colors.white, fontFamily: 'Prompt'), textAlign: TextAlign.center),
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
                                              if (con_hour.text.isEmpty && con_rate.text.isEmpty) {
                                                model = CondoModel.updateCondo(this.id, con_name.text, con_promptpay.text, con_collect, 0, 0);
                                              } else if (con_hour.text.isEmpty) {
                                                model = CondoModel.updateCondo(this.id, con_name.text, con_promptpay.text, con_collect, 0, double.parse(con_rate.text));
                                              } else {
                                                model = CondoModel.updateCondo(this.id, con_name.text, con_promptpay.text, con_collect, double.parse(con_hour.text), double.parse(con_rate.text));
                                              }
                                              await model.updateCondo();
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