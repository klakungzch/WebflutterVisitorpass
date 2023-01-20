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
class AddProfileCondo extends StatefulWidget {
  String lang;
  AddProfileCondo(String lang){
    this.lang = lang;
  }
  @override
  _AddProfileCondoState createState() => _AddProfileCondoState(this.lang);
}
class _AddProfileCondoState extends State<AddProfileCondo> {
  String lang;
  _AddProfileCondoState(String lang){
    this.lang = lang;
  }
  double screenWidth, screenHeight;
  bool checkAdd = true;
  var con_name = new TextEditingController();
  var con_promptpay = new TextEditingController();
  var con_hour = new TextEditingController();
  var con_rate = new TextEditingController();
  var con_collect = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    var word = new Word();
    var url = new UrlImage();
    var colorset = new ColorSet();
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => AddProfileCondo('TH')));
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
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => AddProfileCondo('EN')));
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
                          '${word.condoHeader['$lang']}',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Prompt', color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),  
                SizedBox(height: 15),
                textField(context, con_name, Icon(Icons.person), '${word.condoName['$lang']}', false),  
                margin(context),
                //textField(context, con_promptpay, Icon(Icons.person_add_alt_1), '${word.promptpay['$lang']}', false),  
                Container(
                  child: TextField(
                    controller: con_promptpay,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                    maxLength: 10,
                    decoration: InputDecoration(
                      labelText: '${word.promptpay['$lang']}',
                      prefixIcon: Icon(Icons.person_add_alt_1),
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
                      var model;
                      if (con_collect) {
                        if (con_hour.text.isEmpty) {
                          model = CondoModel(con_name.text, con_promptpay.text, con_collect, 0, double.parse(con_rate.text));
                        } else {
                          model = CondoModel(con_name.text, con_promptpay.text, con_collect, double.parse(con_hour.text), double.parse(con_rate.text));
                        }
                      } else {
                        model = CondoModel(con_name.text, con_promptpay.text, con_collect, 0, 0);
                      }
                      await model.addCondo();
                      Navigator.push(context,  MaterialPageRoute(builder: (context) => CondoManagement(null, this.lang)));
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
}