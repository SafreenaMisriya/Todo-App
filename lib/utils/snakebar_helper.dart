

import 'package:flutter/material.dart';

void showsuccessMessage(BuildContext context, {required  String message}){
    final snackBar=SnackBar(content:Text(message,
    style:const TextStyle(color: Colors.black,),),
    backgroundColor:const Color.fromARGB(255, 42, 211, 129,));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
 void showerrorMessage(BuildContext context,{required String message}){
    final snackBar=SnackBar(content:Text(message,
    style:const TextStyle(color: Colors.black,),),
    backgroundColor:Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
