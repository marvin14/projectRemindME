import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EventPage extends StatefulWidget{
  @override
_EventPageState createState() => _EventPageState();
  }

  class _EventPageState extends State<EventPage>{
  @override
  ScrollController _sc = ScrollController();
 
  final db = Firestore.instance;

  Widget build(BuildContext context) {
    
     return Container(
      
      child: ListView(
        controller: _sc,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: EdgeInsets.all(8.0),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('todo').snapshots(),
            builder: (context,snapshot){
              if (snapshot.hasData){
                return Column(
                  children: snapshot.data.documents.map((doc)=>buildItem(doc)).toList());
                 
                                }
                                else{
                                  return SizedBox();
                                }
                              },)
                          ],
                        ),);
                      
                      }
                  
    void deleteData(DocumentSnapshot doc) async{
    await db.collection('todo').document(doc.documentID).delete();
  }

    Card buildItem(DocumentSnapshot doc){
      return Card(
        child:Padding(padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Event: ${doc.data['Event']}',
            style: TextStyle(fontSize: 25),),
          Text(
            'Description: ${doc.data['Description']}',
            style: TextStyle(fontSize: 15),),
            Row(mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              MaterialButton(child: Text('Delete'),
              onPressed: ()=> deleteData(doc),),
              MaterialButton(child: Text('Update'),
              onPressed: (){},)
            ],)
        ],
        ),
        ) ,
        );

    }
  }