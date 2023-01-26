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
class AddUserGuard extends StatefulWidget {
  String condoName, lang;
  AddUserGuard(String condoName, String lang){
    this.condoName = condoName;
    this.lang = lang;
  }
  @override
  _AddUserGuardState createState() => _AddUserGuardState(this.condoName, this.lang);
}
class _AddUserGuardState extends State<AddUserGuard> {
  String condoName, lang;
  _AddUserGuardState(String condoName, String lang){
    this.condoName = condoName;
    this.lang = lang;
  }
  double screenWidth, screenHeight;
  bool checkAdd = true;
  var firstname = new TextEditingController();
  var lastname = new TextEditingController();
  var username = new TextEditingController();
  var password = new TextEditingController();
  var confirmpass = new TextEditingController();
  var listUN = [];  

  @override
  void initState() {
    super.initState();
    getDataToCheck();
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var word = new Word();
    var url = new UrlImage();
    var colorset = new ColorSet();
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => AddUserGuard(this.condoName, 'TH')));
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => AddUserGuard(this.condoName, 'EN')));
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
                          '${word.adduserHeader['$lang']}',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                        ),
                      ),
                    ],
                  ),
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
                          Navigator.push(context,  MaterialPageRoute(builder: (context) => ChooseCondo(null, 'add', null, this.lang)));
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                textField(context, firstname, Icon(Icons.person), '${word.firstname['$lang']}', false),  
                margin(context),
                textField(context, lastname, Icon(Icons.person_add_alt_1), '${word.lastname['$lang']}', false),  
                margin(context),
                textField(context, username, Icon(Icons.supervised_user_circle), '${word.username['$lang']}', false),  
                margin(context),
                textField(context, password, Icon(Icons.verified_user), '${word.password['$lang']}', true), 
                margin(context),
                textField(context, confirmpass, Icon(Icons.verified), '${word.confirmPassword['$lang']}', true), 
                margin(context),
                ElevatedButton(
                  onPressed: () async {
                    if(firstname.text.isEmpty || lastname.text.isEmpty || username.text.isEmpty || password.text.isEmpty || confirmpass.text.isEmpty){
                      dialogCustom(context, '${word.dialogAdduserHeader1['$lang']}', this.lang);  
                    }
                    else if(password.text != confirmpass.text){
                      dialogCustom(context, '${word.dialogAdduserHeader2['$lang']}', this.lang);               
                      password.clear();
                      confirmpass.clear();
                    }
                    else{
                      for (var item in listUN) {
                        if(item == username.text){
                          checkAdd = false;
                          print('$item == ${username.text}');
                          break;
                        }
                      }
                      if(checkAdd == true){
                        var model = UserguardModel(0, condoName, firstname.text, lastname.text, username.text, password.text, false);
                        await model.addUserGuard();
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => GuardManagement(null, this.lang)));
                      }
                      else{
                        dialogCustom(context, '${word.dialogAdduserHeader3['$lang']}', this.lang); 
                        checkAdd = true;
                      }
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
  Future getDataToCheck() async{
    await FirebaseFirestore.instance
    .collection('UserGuard')
    .get()
    .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        listUN.add(doc['username']);
        //print(listUN);
      })
    });
  }
}