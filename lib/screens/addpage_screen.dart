
// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo/services/todo_services.dart';
import 'package:todo/utils/snakebar_helper.dart';
class AddPage extends StatefulWidget {
  final Map? todo;
  const AddPage({super.key,
  this.todo
  });

  @override
  State<AddPage> createState() => _AddPageState();
}


class _AddPageState extends State<AddPage> {
  TextEditingController titlecontroller =TextEditingController();
  TextEditingController decriptioncontroller= TextEditingController();
  bool isdEdit =false;
  @override
  void initState() {
    super.initState();
    final todo=widget.todo;
    if(todo !=null){
      isdEdit=true;
      final title=todo['title'];
      final description=todo['description'];
      titlecontroller.text=title;
      decriptioncontroller.text=description;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        centerTitle: true,
        title:  Text(isdEdit? 'Edit Todo':'Add Todo'),
      ),
      body: ListView(
        padding:const EdgeInsetsDirectional.all(20),
        children: [
          TextFormField(
            controller:titlecontroller ,
            decoration:const InputDecoration(
              hintText: 'Title'
            ),
          ),
         const SizedBox(height: 30,),
          TextFormField(
            controller: decriptioncontroller,
            decoration:const InputDecoration(
              hintText: 'Summary',
            ),
            keyboardType: TextInputType.multiline,
            maxLines: 5,
          ),
          const  SizedBox(height: 70,),
          ElevatedButton(onPressed:isdEdit? updatedata :submitdata,
        style: ElevatedButton.styleFrom(
          backgroundColor:const Color.fromARGB(255, 42, 211, 129)
        ), child: Text(isdEdit? 'Update':'Submit',style:const TextStyle(color: Colors.black),),
          )
        ],
      ),
    );
  }
  Future<void>updatedata()async{
    final todo= widget.todo;
    if(todo==null){
      stdout.write("You can call update without todo data");
      return;
    }
    final id=todo['_id'];
    final title =titlecontroller.text;
    final description= decriptioncontroller.text;
    final body={
      "title": title,
      "description":description,
      "is_completed":false,
    };
   final issuccess=await Todoservice.updateTodo(id, body);
     if(issuccess){
      showsuccessMessage(context,message: 'Updation is successful');
    }else{
      showerrorMessage(context,message: 'Updation failed');
    }
  }
  Future<void> submitdata()async{
    final title =titlecontroller.text;
    final description= decriptioncontroller.text;
    final body={
      "title": title,
      "description":description,
      "is_completed":false,
    };
    final isSuccess=await Todoservice.addTodo(body);
    if(isSuccess){
    
     stdout.write('Creation  failed');
      showsuccessMessage(context,message: 'Creation is failed');
    }else{
      stdout.write('Creation successful');
      titlecontroller.text='';
      decriptioncontroller.text='';
      showsuccessMessage(context,message: 'Creation is successful');
    }
  }
 
} 