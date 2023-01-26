import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitorguard/Language/UrlImage.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Page/Log.dart';
import 'package:visitorguard/Widgets/Margin.dart';
import 'package:visitorguard/Widgets/ShowAlertDialog.dart';
// ignore: must_be_immutable
class HomePageLogin extends StatefulWidget {
  String lang;
  HomePageLogin(String lang){
    this.lang = lang;
  }
  @override
  _HomePageLoginState createState() => _HomePageLoginState(this.lang);
}
class _HomePageLoginState extends State<HomePageLogin> {
  String lang;
  _HomePageLoginState(String lang){
    this.lang = lang;
  }

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var username = new TextEditingController();
    var password = new TextEditingController();
    var word = new Word();
    var url = new UrlImage();
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff0000b3), Color(0xff0000ff)]
          )
        ),
        child: SingleChildScrollView(
          child: Column(
            children:[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(blurRadius: 6),
                      ],
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          this.lang = 'TH';
                        });
                      }, 
                      child: Image.network(
                        '${url.imgThai}',
                        width: 40,
                        height: 25,
                        fit:BoxFit.fill
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(blurRadius: 6),
                      ],
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          this.lang = 'EN';
                        });
                      }, 
                      child: Image.network(
                        '${url.imgEng}',
                        width: 40,
                        height: 25,
                        fit:BoxFit.fill
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: screenHeight*0.15),
              Container(
                constraints: BoxConstraints(minWidth: 350.0, minHeight: 400.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 6),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 120.0, maxHeight: 120.0),
                      child: Image.asset(
                        'images/policeman.png',
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      constraints: BoxConstraints(maxWidth: 300.0, maxHeight: 40.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${word.signin['$lang']}',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Prompt'),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    textFieldLogin(context, username, Icon(Icons.supervised_user_circle_rounded), '${word.username['$lang']}', false),
                    SizedBox(height: 10),
                    textFieldLogin(context, password, Icon(Icons.check_circle), '${word.password['$lang']}', true),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if(username.text.trim() == 'admin' && password.text.trim()  == '1234'){
                          await FirebaseAuth.instance.signInAnonymously();
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('userlogin', username.text.trim());

                          Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, lang, 1)));
                        }
                        else{
                          dialogCustom(context, '${word.dialogLoginHeader['$lang']}', this.lang);
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
                          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "${word.login['$lang']}",
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
            ]
          ),
        ),
      ),
    );
  }
  Widget textFieldLogin(BuildContext context, TextEditingController controller, Icon icon, String label, bool hideText) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.0, maxHeight: 50.0),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18),
        obscureText: hideText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.amber,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }
}