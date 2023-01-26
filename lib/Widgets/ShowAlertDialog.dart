import 'package:flutter/material.dart';
import 'package:visitorguard/Language/Word.dart';

void dialogCustom(BuildContext context, String textShow, String lang){
  var word = new Word();
  showDialog( 
    context: context, 
    builder: (context) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
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
            color: Colors.redAccent,
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
                    '${word.alert['$lang']}', 
                    style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: 'Prompt'),
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
                child: Text(textShow, style: TextStyle(color: Colors.white, fontFamily: 'Prompt'), textAlign: TextAlign.center),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: (){
                      return Navigator.of(context).pop(true);
                    }, 
                    child: Text('${word.close['$lang']}'),
                    style: TextButton.styleFrom(
                      primary: Colors.redAccent,
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

