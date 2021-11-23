import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todoapp/taskdetail.dart';

class TodoAppPage extends StatefulWidget {
  const TodoAppPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<TodoAppPage> createState() => _TodoAppPageState();
}

class _TodoAppPageState extends State<TodoAppPage> {
  List<TaskItem> itemsList = <TaskItem>[];
  TextEditingController taskController =new TextEditingController();
  bool isTaskEmpty=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Add Task',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40)
              ),
              Row(
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: [
                  buildTaskAdder(taskController),
                  Center(child: IconButton(icon: Icon(Icons.add_task),
                    color: Colors.blueAccent,
                    iconSize: 45,
                    onPressed: () {
                        setState(() {
                          if(taskController.value.text.isEmpty){
                            isTaskEmpty=true;
                          }else {
                            this.isTaskEmpty=false;
                            addTask(taskController.value.text);
                            taskController.clear();
                          }
                        });
                  },),)
                ],
              ),
              const Divider(
               color: Colors.black,
                thickness: 2.5,
              ),
              const Text(
                  'Task List',
                  style: TextStyle(
                    fontStyle:  FontStyle.italic,
                      fontSize: 25)
              ),
              Expanded(child: showTaskList(),)
              ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  showAddButton(){

  }

  Widget showTaskList(){
    if(itemsList.isEmpty){
      return Center(child:  Text(
          '<No task pending>',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 30)
      ),);
    }else{
        return SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: this.itemsList.length,
              itemBuilder: /*1*/ (context, i) {
                return _buildEachTask(itemsList[i]);
              }),
          );
    }
  }

  addTask(String taskName){
    this.itemsList.add(new TaskItem(taskName: taskName, isTaskComplete: false));
  }

  deleteTask(int index){
    this.itemsList.removeAt(index);
  }

  Widget _buildEachTask(TaskItem eachItem) {
    return ListTile(
      leading: IconButton(
        iconSize: 30,
        icon:Icon(
          eachItem.isTaskComplete ? Icons.done_outline_sharp: Icons.dangerous_outlined,
          color: eachItem.isTaskComplete?Colors.green:Colors.red,
          semanticLabel: eachItem.isTaskComplete?'Mark as done':'Mark as not done',
        ) ,
          onPressed: () {
            setState(() {
              eachItem.setTaskDone(!eachItem.isTaskComplete);
            });
        },
        ),

      trailing:IconButton(
        iconSize: 30,
        icon:const Icon(
          Icons.delete_sharp,
          color: Colors.red,
          semanticLabel: 'Delete this task',
        ) ,
        onPressed: () {
          setState(() {
            this.itemsList.remove(eachItem);
          });
        },
      ),
      title: Text(
        eachItem.getTaskName(),
        style: const TextStyle(fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }

  Widget buildTaskAdder(TextEditingController controller){
    return SizedBox(
      height: 80,
      width: 300,
      child: TextField(
        controller: controller,
        onChanged: (String value){
          setState(() {
            this.isTaskEmpty=value.isEmpty;
          });
        },
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            enabled: true,
            labelText: "Enter your task name",
            errorText: this.isTaskEmpty ? 'Task name cannot be empty' : null,
        ),
      ),
    );
  }

}