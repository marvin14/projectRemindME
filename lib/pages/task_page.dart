import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  @override

_TaskPageState createState() => _TaskPageState();
 
  }

  class Task{
    final String task;
    final bool isFinish;
    const Task(this.task, this.isFinish);

  }
  final List<Task> _taskList = [
    Task("Submit Mobile App Project",true),
    Task("Submit Mobile App Project",true), 
    Task("Submit Mobile App Project",true),
    Task("Submit Mobile App Project",true),
    Task("Submit Mobile App Project",true),
    Task("Submit Mobile App Project",true),
    Task("Submit Mobile App Project",true),
  
  ];
class _TaskPageState extends State<TaskPage>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemCount: _taskList.length,
      itemBuilder: (context , index){
        return _taskList[index].isFinish
        ? _taskUncomplete(_taskList[index].task)
        : _taskComplete(_taskList[index].task);
         
      },
    );

  }

  Widget _taskUncomplete(String task) {
    return Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row
             (children: <Widget>[
                Icon(Icons.radio_button_unchecked,
                color: Theme.of(context).accentColor,
                size: 20,
                ),
                SizedBox(width: 28,
                ),
                Text(task)
            ],),
          );
  }
      }

Widget _taskComplete(String task) {
   
        return Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row
                 (children: <Widget>[
                    Icon(Icons.radio_button_checked,
                size: 20,
                ),
                SizedBox(width: 28,
                ),
                Text(task)
            ],),
          );
  }
      
