import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
 import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../constants/constants.dart';


double parseDouble(String ? text) {
  if (text == '' || text == null) {
    return 0;
  }
  return double.parse(text);
}

String currentTime(){
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  return dateFormat.format(DateTime.now());
}

String doFormat(double number) {
  return (number - number.truncate()) == 0
      ? number.truncate().toString()
      : number.toStringAsFixed(2);
}

double toDouble(value){
  return double.parse(value is int ? value.toStringAsFixed(2) : doFormat(value));
}

int intParser(String text) {
  return text.isNotEmpty ? int.parse(text): 0;
}

String getCurrentDate(){
  return DateTime.now().toString().substring(0,10);
}

String getDateFormat(DateTime date){
  return date.toString().substring(0,10);
}

String getCurrentTime(){
  DateTime dateTime =  DateTime.now();
  int hour = dateTime.hour > 12 ? dateTime.hour % 12 : dateTime.hour;
  return "${hour < 10 ?  "0${hour}" : hour }:${
      dateTime.minute < 10 ?  "0${dateTime.minute}" : dateTime.minute} ${hour< 13 ? 'am': 'pm'}";
}

String getTimeFormat(DateTime dateTime){
  int hour = dateTime.hour > 12 ? dateTime.hour % 12 : dateTime.hour;
  return "${hour < 10 ?  "0${hour}" : hour }:${
      dateTime.minute < 10 ?  "0${dateTime.minute}" : dateTime.minute} ${dateTime.hour < 13 ? 'am': 'pm'}";
}

String getTimeFormat2(TimeOfDay timeOfDay){
  int hour = timeOfDay.hour > 12 ? timeOfDay.hour % 12 : timeOfDay.hour;
  return "${hour < 10 ?  "0${hour}" : hour }:${
      timeOfDay.minute < 10 ?  "0${timeOfDay.minute}" : timeOfDay.minute} ${timeOfDay.hour < 13 ? 'am': 'pm'}";
}

void showSnackBar(context,text){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    content: Container(
        child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,)),
    duration: Duration(seconds: 2),
    backgroundColor: AppColors.pinkLight,
  ));
}

double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

void showErrorSnackbar(context,text){
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    content: Container(
        child: Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),textAlign: TextAlign.center,)),
    duration: Duration(seconds: 2),
    backgroundColor: Colors.redAccent,
  ));
}

bool isValidateInteger(String source){
  try{
    int.parse(source);
    return true;
  }catch(e){
    return false;
  }
}

showLoadingProgress(BuildContext context){
  showCupertinoModalPopup(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return CupertinoAlertDialog(
          content: CupertinoActivityIndicator(radius: 20,color: AppColors.blueDark,),
        );
      }
  );
}


bool isDigits(String source){
  try {
    return RegExp(r'^[0-9]+$').hasMatch(source);
  } catch (e) {
    return false;
  }
}

showConfirmation({context,required String text,onPressed}){
  return Alert(context: context, title: text,
      style: AlertStyle(
        isCloseButton: false,
        overlayColor: Color(0xDD000000).withOpacity(0.1),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.transparent)
        ),
      )
      , buttons: [
        DialogButton(
            child: Text(
              'ok',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () => onPressed()),
        DialogButton(
            color: Colors.black12,
            child: Text(
              'cancel',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600),
            ),
            onPressed: () => Navigator.pop(context)),
      ]).show();
}


String getStringTime(String time){
  if(time.split(' ')[1] == 'pm'){
    return '${int.parse((time.split(' ')[0]).split(':')[0]) + 12}:${(time.split(' ')[0]).split(':')[1]}';
  }
  return '${(time.split(' ')[0]).split(':')[0]}:${(time.split(' ')[0]).split(':')[1]}';
}

showAlert(context,text){
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:  [
            SizedBox(height: 5,),
            Text(text),
            SizedBox(height: 15,),
            MaterialButton(
              padding: EdgeInsets.all(5),
              color: AppColors.blueDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onPressed: ()=> Navigator.pop(context),
              child: Text('ok',style: TextStyle(fontSize: 18,color: Colors.white),),
            ),
          ],
        ),
      ));
}
