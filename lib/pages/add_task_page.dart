import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget{

  _AddTaskPageState createState () => _AddTaskPageState();
}
class _AddTaskPageState extends State <AddTaskPage>{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child:Text(
              "Add new task",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          )),
          SizedBox(
            height:24 ,),
          TextField(
            decoration:InputDecoration(
              border:OutlineInputBorder (
                borderRadius:BorderRadius.all(Radius.circular(12)) 
                ),
                labelText: 'Enter task name'
                ),
               ),

               
               _actionButton(context)
              ],
      ),
    );
    
      }

  Row _actionButton(BuildContext context) {
    return Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: <Widget>[
               MaterialButton(
                 onPressed: (){
                   Navigator.of(context).pop();
                 },
                 child: Text("Close")
                 ,),
                MaterialButton(
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(12.0)),
                  onPressed:(){},
                  child: Text("Save"),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor, ) 
             ],);
  }


}