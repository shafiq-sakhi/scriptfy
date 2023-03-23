import 'package:flutter/material.dart';

const mTextFieldDecoration = InputDecoration(
    hintText: 'Enter value',
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 90.0),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(25.0)),
),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(25.0))
  ),

focusedBorder: OutlineInputBorder(
borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
borderRadius: BorderRadius.all(Radius.circular(25.0))
),


);



