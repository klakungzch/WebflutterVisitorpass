import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:visitorguard/Language/Word.dart';
import 'package:visitorguard/Page/CondoManagement.dart';
import 'package:visitorguard/Page/GuardManagement.dart';
import 'package:visitorguard/Page/HomePageLogin.dart';
import 'package:visitorguard/Page/Log.dart';
import 'package:visitorguard/Page/LogTest.dart';
import '../Page/NewsManagement.dart';

Widget drawer(BuildContext context, String lang){
  var word = new Word();
  return Drawer(  
    child: ListView(  
      padding: EdgeInsets.zero,  
      children: <Widget>[  
        UserAccountsDrawerHeader(  
          accountName: Text("${word.accountName['$lang']}", style: TextStyle(fontSize: 18, fontFamily: 'Prompt')),  
          accountEmail: Text("Visitor-Guard Dashboard", style: TextStyle(fontSize: 18, fontFamily: 'Prompt')),
          decoration: BoxDecoration(
            color: Color(0xff0000b3),
            /*gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color.fromARGB(255, 0, 153, 255), Color.fromARGB(255, 0, 51, 153)]
            )*/
          ),
        ),  
        ListTile(  
          leading: Icon(Icons.bar_chart_rounded), 
          title: Text(
            "${word.menu2['$lang']}",
            style: TextStyle(fontFamily: 'Prompt')
          ),  
          onTap: () {  
            Navigator.push(context, new MaterialPageRoute(builder: (context) => Log(null, '1', 0, lang, 1)));
          },  
        ),
        ListTile(         
          leading: Icon(Icons.supervised_user_circle), 
          title: Text(
            "${word.menu3['$lang']}",
            style: TextStyle(fontFamily: 'Prompt')
          ),   
          onTap: () {  
            Navigator.push(context, new MaterialPageRoute(builder: (context) => GuardManagement(null, lang)));
          },  
        ),
        ListTile(  
          leading: Icon(Icons.home_work_rounded ),
          title: Text(
            "${word.menu4['$lang']}",
            style: TextStyle(fontFamily: 'Prompt')
          ),  
          onTap: () {  
            Navigator.push(context, new MaterialPageRoute(builder: (context) => CondoManagement(null, lang)));
          },  
        ),
        ListTile(
          leading: Icon(Icons.newspaper ),
          title: Text(
              "${word.menu6['$lang']}",
              style: TextStyle(fontFamily: 'Prompt')
          ),
          onTap: () {
            Navigator.push(context, new MaterialPageRoute(builder: (context) => NewsManagement(null, lang)));
          },
        ),
        /*ListTile(  
          leading: Icon(Icons.pages),
          title: Text(
            "Log Test",
            style: TextStyle(fontFamily: 'Prompt')
          ),  
          onTap: () {  
            Navigator.push(context, new MaterialPageRoute(builder: (context) => LogTest(null, lang, 1)));
          },  
        ),*/ 
        ListTile(  
          leading: Icon(Icons.exit_to_app), 
          title: Text(
            "${word.menu5['$lang']}",
            style: TextStyle(fontFamily: 'Prompt')
          ),   
          onTap: () {  
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
                              '${word.dialogDrawerHeader['$lang']}', 
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
                          child: Text('${word.dialogDrawerDetail['$lang']}', style: TextStyle(color: Colors.white, fontFamily: 'Prompt'), textAlign: TextAlign.center,),
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
                                /*Navigator.of(context).popUntil(ModalRoute.withName('/root'));*/
                                await FirebaseAuth.instance.signOut();
                                Navigator.pushAndRemoveUntil(
                                  context, MaterialPageRoute(
                                    builder: (BuildContext context) => HomePageLogin(lang),
                                  ),
                                  (route) => false,
                                );
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
          },  
        ),  
      ],  
    ),  
  );  
}