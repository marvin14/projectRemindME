

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState()=> _HomePageState(); 
   
    }
  
  class _HomePageState extends State<HomePage> {
     CalendarController _controller;
  @override
  void initState(){
    super.initState();
    _controller = CalendarController();
  }


  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar:AppBar(
        title: Text("Calendar"),) ,
        body: SingleChildScrollView(
          child:Column( 
            children: <Widget>[
            TableCalendar(calendarController: _controller,)
         
            ],

          ),
          ),
      );
  }


}