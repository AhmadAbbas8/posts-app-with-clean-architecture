import 'package:flutter/material.dart';

class CustomSnackBar{
  CustomSnackBar._();
 static showSnackBar({required BuildContext context,required String message,required Color color}){
    return  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
      ),
    );
  }
}