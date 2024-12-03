

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:hive/hive.dart";
import "package:todo/data/database.dart";
import "package:todo/util/dialog_box.dart";
import "package:todo/util/todo_tile.dart";

class HomePage extends StatefulWidget {
 HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

//box
final _mybox = Hive.box('mybox');
//text controller
final _controller = TextEditingController();

ToDoDataBase db = ToDoDataBase();


@override
  void initState() {
    //se for a primeira vez inicializando  o programa vai chamar de database.dart e criar a lista inicial

    if(_mybox.get('TODOLIST')== null){
      db.createInitialData();
    }else{
      //se tiver ja os dados la,vai carregar da toDoList
      db.loadData();
    }
    super.initState();
  }
  //checkbox
  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }
  //salvar nova tarefa
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]); 
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }
  //Metodo para criar nova tarefa
 void createNewTask(){
  showDialog(
    context: context, 
    builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: Navigator.of(context).pop,
        );
    },
    );
    
  }
  //Delete new task

void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
  });
  db.updateDataBase();
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.black,
        centerTitle: true,
        title: Text('TO DO',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color:Colors.white),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: Column(children: [
          DrawerHeader(child: 
          Text("To Do APP",
          style: TextStyle(
            color: Colors.white,fontSize: 48),
            )
            ),
       
          ListTile(
            leading: Icon(Icons.info),
            title: Text("SAIBA MAIS",style: TextStyle(color: Colors.white),),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/saiba_mais');
            },
          ),
          

        ],)

        ),
        

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.black,
        child: Icon(Icons.add,
        color: Colors.white,),

        
        ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
            
            );
        },
      )
    );
  }
}
