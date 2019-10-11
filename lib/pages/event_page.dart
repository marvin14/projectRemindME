import 'package:flutter/material.dart';

class EventPage extends StatefulWidget{
  @override
_EventPageState createState() => _EventPageState();
  }

  class _EventPageState extends State<EventPage>{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(0.0),
      itemBuilder: (context, index){
        return Row(
          children: <Widget>[
            Container(
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                    boxShadow:[
                    BoxShadow(
                      offset:Offset(0,3 ),
                      color: Color(0x20000000),
                      blurRadius: 5)
                     ] ),
                child: Icon(Icons.fiber_manual_record,
                size: 20,
                color: Theme.of(context).accentColor,
                ),
              ),
            ),
            Container(
              width: 70,
              child: Text("80:00")),
            Expanded(
                          child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [BoxShadow(
                    color: Color(0x20000000),
                    blurRadius: 5,
                    offset: Offset(0,3),

                    )],
                    ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text("Mobile Application- IT elective 4"),
                    SizedBox(height: 12,),Text("Submittion of Project")
                  ],),
                ),
              ),
            )


          ],
        );
      }
    );
  }

  }
