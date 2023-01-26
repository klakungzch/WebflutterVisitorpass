import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitorguard/Language/UrlImage.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Model/userguard_model.dart';
import 'package:visitorguard/Page/ChooseCondo.dart';
import 'package:visitorguard/Page/GuardManagement.dart';
import 'package:visitorguard/Page/Log.dart';
import 'package:visitorguard/Widgets/ColorSet.dart';
import 'package:visitorguard/Widgets/Margin.dart';
import 'package:visitorguard/Widgets/ShowAlertDialog.dart';
import 'package:visitorguard/Widgets/TextField.dart';
// ignore: must_be_immutable
class EditUserGuard extends StatefulWidget {
  String id;
  String condoName;
  String lang;
  EditUserGuard(String id, String condoName, String lang){
    this.id = id;
    this.condoName = condoName;
    this.lang = lang;
  }
  @override
  _EditUserGuardState createState() => _EditUserGuardState(this.id, this.condoName, this.lang);
}
class _EditUserGuardState extends State<EditUserGuard> {
  String id;
  String condoName;
  String lang;
  int radioStatus;
  _EditUserGuardState(String id, String condoName, String lang){
    this.id = id;
    this.condoName = condoName;
    this.lang = lang;
  }
  double screenWidth, screenHeight;
  var word = new Word();
  var url = new UrlImage();
  var colorset = new ColorSet();
  var userStatus;
  CollectionReference users = FirebaseFirestore.instance.collection('UserGuard');

  @override
  void initState() {
    users.doc(this.id).get().then((value) {
      userStatus = value['status'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var firstName = new TextEditingController();
    var lastName = new TextEditingController();
    var username = new TextEditingController();
    var password = new TextEditingController();
    var confirmpass = new TextEditingController();
    bool status;
    //var sizeFont = (screenHeight/35 + screenWidth/70)/2;
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
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => EditUserGuard(this.id, condoName, 'TH')));
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
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => EditUserGuard(this.id, condoName, 'EN')));
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
        future: users.doc(id).get(),
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
          firstName.text = snapshot.data['firstName'];
          lastName.text = snapshot.data['lastName'];
          username.text = snapshot.data['username'];
          confirmpass.text = snapshot.data['pin'];
          password.text = snapshot.data['pin'];
          return SingleChildScrollView(
            child: Center(
              child: Container(
                width: screenWidth*0.7,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child :Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(screenWidth>1000)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          topUserEdit(context, '${word.edituserHeader['$lang']} : ${snapshot.data['firstName']}'),
                          topStatus(context)
                        ]
                      )
                          
                    else
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          topUserEdit(context, '${word.edituserHeader['$lang']} : ${snapshot.data['firstName']}'),
                          SizedBox(height: 15),
                          topStatus(context)
                        ],
                      ),
                    SizedBox(height: 25),
                    ListTile(
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Color.fromARGB(255, 191, 191, 191)))),
                        child: Icon(Icons.home_outlined, color: colorset.blueTwo, size: 40), // Hardcoded to be 'x'
                      ),
                      title: Wrap(
                        spacing: 5,
                        children: [
                          new Text('${word.condoName['$lang']} : $condoName' ,style: (TextStyle(fontFamily: 'Prompt'))),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            tooltip: 'Edit condo : $condoName',
                            onPressed: (){
                              Navigator.push(context,  MaterialPageRoute(builder: (context) => ChooseCondo(this.id, 'edit', null, this.lang)));
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    textField(context, firstName, Icon(Icons.person), '${word.firstname['$lang']}', false),             
                    margin(context),
                    textField(context, lastName, Icon(Icons.person_add_alt_1), '${word.lastname['$lang']}', false),    
                    margin(context),
                    textField(context, username, Icon(Icons.supervised_user_circle), '${word.username['$lang']}', false),   
                    margin(context),
                    textField(context, password, Icon(Icons.verified_user), '${word.password['$lang']}', true),
                    margin(context),
                    textField(context, confirmpass, Icon(Icons.verified), '${word.confirmPassword['$lang']}', true),
                    margin(context),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () async {
                        if(username.text.isEmpty || password.text.isEmpty || confirmpass.text.isEmpty){
                          dialogCustom(context, '${word.dialogAdduserHeader1['$lang']}', this.lang);                      
                        }
                        else if(password.text != confirmpass.text){
                          dialogCustom(context, '${word.dialogAdduserHeader2['$lang']}', this.lang); 
                          password.clear();
                          confirmpass.clear();
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
                                            '${word.dialogEdituserHeader1['$lang']}', 
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
                                        child: Text('${word.dialogEdituserDetail1_1['$lang']} ${snapshot.data['firstName']}${word.dialogEdituserDetail1_2['$lang']}', style: TextStyle(color: Colors.white, fontFamily: 'Prompt'), textAlign: TextAlign.center),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextButton(onPressed: (){
                                              Navigator.of(context).pop();
                                            }, 
                                            child: Text('${word.cancel['$lang']}'),
                                            style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              textStyle: TextStyle(fontFamily: 'Prompt'),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          ElevatedButton(onPressed: (){
                                              if(radioStatus == 1) status = true;
                                              else if(radioStatus == 2) status = false;
                                              else status = snapshot.data['status'];
                                              var model = UserguardModel.defaultIDStatus(id, condoName, firstName.text, lastName.text, username.text, password.text, status);
                                              model.updateUserGuard();
                                              Navigator.push(context,  MaterialPageRoute(builder: (context) => GuardManagement(null, this.lang)));
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
  Widget topStatus(BuildContext context){
    if(userStatus == true) {
      radioStatus = 1;
    } else if (userStatus == false) {
      radioStatus = 2;
    }
    return Container(
      height: 50,
      constraints: BoxConstraints(maxWidth: 200),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: radioStatus,
            onChanged: (val) {
              setState(() {
                radioStatus = 1;
                userStatus = true;
              });
            },
          ),
          Text(
            'True',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          Radio(
            value: 2,
            groupValue: radioStatus,
            onChanged: (val) {
              setState(() {
                radioStatus = 2;
                userStatus = false;
              });
            },
          ),
          Text(
            'False',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Prompt',
            ),
          ),
          SizedBox(width: 3),
        ],
      ),
    );             
  }
}