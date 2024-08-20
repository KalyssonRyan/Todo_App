import 'package:hive/hive.dart';

class ToDoDataBase {
  
  List toDoList=[];
  
  //reference
final _mybox = Hive.box('mybox');

void createInitialData(){
  toDoList=[
    ['feel free',false],
    ['to use the app',false]
  ];
}
void loadData(){
  toDoList = _mybox.get('TODOLIST');
}
void updateDataBase(){
  _mybox.put('TODOLIST', toDoList);
}
}