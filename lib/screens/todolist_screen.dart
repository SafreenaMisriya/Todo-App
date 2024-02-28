// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:todo/screens/addpage_screen.dart';
import 'package:todo/services/todo_services.dart';
import 'package:todo/utils/snakebar_helper.dart';
import 'package:todo/widget/todo_card.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}


class _TodoListPageState extends State<TodoListPage> {
  List item=[];
  bool isloading =true;
  @override
  void initState() {
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color.fromARGB(255, 42, 211, 129),
        centerTitle: true,
        title:const Text('Todo List',
        style: TextStyle(
          fontWeight: FontWeight.w400 ,
        ),),
      ),
      body: Visibility(
        visible: isloading,
        replacement: RefreshIndicator(
          onRefresh: getdata,
          child: Visibility(
            visible: item.isNotEmpty,
            replacement: Center(child: Text('No item in Todo',style: Theme.of(context).textTheme.headlineSmall),),
            child: ListView.builder(
              padding:const EdgeInsets.all(8),
              itemCount: item.length,
              itemBuilder:(context,index){
                final items=item[index]as Map;
              return TodoCard(index: index,
               item: items,
                navigateEdit:  navigatetoEdit,
                 deleteById:deleteid );
            }),
          ),
        ),
        child:const Center(child:CircularProgressIndicator() ,),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: navigatetoAdd,
        backgroundColor:const Color.fromARGB(255, 42, 211, 129) ,
        child:const Icon(Icons.add,color: Colors.black,),
         ),
    );
  }
  Future<void> navigatetoAdd()async{
    final route=MaterialPageRoute(
      builder: (context)=>const AddPage());
    await  Navigator.push(context, route);
    setState(() {
      isloading=true;
    });
    getdata();
  }
   Future<void> navigatetoEdit(Map item)async{
    final route=MaterialPageRoute(
      builder: (context)=> AddPage(todo:item));
    await  Navigator.push(context, route);
     setState(() {
      isloading=true;
    });
    getdata();
  }
  Future<void>getdata()async{
   final response =await Todoservice.fetchtodo();
    if(response !=null){
      setState(() {
        item=response;
      });
    }else{
      showerrorMessage(context,message: 'Something went wrong');
    }
    setState(() {
      isloading=false;
    });
  }
  Future<void>deleteid(String id)async{
    final issuccess=await Todoservice.deleteById(id);
    if(issuccess){
   final filtered =item.where((element) => element['_id'] !=id).toList();
      setState(() {
        item=filtered;
      });
      showsuccessMessage(message: 'Deleted Successfully',context);
      
    }else{
      showerrorMessage(context,message: 'Unable to Delete');
    }
  }
   
  
}