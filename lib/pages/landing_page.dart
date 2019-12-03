
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/pages/add_event_page.dart';
import 'package:project/pages/add_task_page.dart';
import 'package:project/pages/calendar.dart';
import 'package:project/pages/event_page.dart';
import 'package:project/pages/task_page.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/pages/auth.dart';


class MyHomePage extends StatefulWidget {
 
   MyHomePage({Key key , this.auth, this.onSignedOut,}) : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async{
    try{
      await auth.signOut();
      onSignedOut();
    }catch(e){
      print(e);
    }
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 


class _MyHomePageState extends State<MyHomePage> {
  
  PageController _pageController = PageController();
  double currentPage = 0;

 

  @override
  Widget build(BuildContext context) {
    _pageController.addListener((){
      setState(() {
       currentPage =_pageController.page; 
      });
    });
    
      return Scaffold(
        appBar: AppBar(title: Text(""),),
        drawer: Drawer(child: ListView(children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text ("Bonani Marvin"), 
            accountEmail: Text("marvinbonani14@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor:Colors.white ,
              child: Text("M"),),
            ),

        
          ListTile(title: Text("Profile"),
          trailing: Icon(Icons.arrow_forward),          
          ),
          Divider(),
           ListTile
           (title: Text("Calendar"),
          trailing: Icon(Icons.arrow_forward),
          onTap:()=>Navigator.of(context).pushNamed("/calendar") ,
          ),
          Divider(),        
           ListTile(title: Text("Settings"),
          trailing: Icon(Icons.settings),  
          ), 
          Divider(),
          FlatButton(onPressed:(){}, 
          child: Text('Signout', style: TextStyle(fontSize: 17.0),) ,)

        ],),),
        body:Stack(
          children: <Widget>[_mainContext(context),
          Positioned(
            right:0,
        child: Text("RM" ,style: TextStyle(fontSize: 200, color: Color(0x10000000)),)
          ,)],
        ),
         
         
        floatingActionButton: FloatingActionButton(
          onPressed:(){
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context){
                  return Dialog(
                    child: currentPage == 0 ? AddTaskPage() : AddEventPage(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),);
                }
              );

          },
          child: Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          
          bottomNavigationBar:BottomAppBar(
            color: Colors.grey[50],
            shape: CircularNotchedRectangle(),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(onPressed:(){},
                icon: Icon(Icons.settings)
                ,),
              ],
            ) 
            ,) ,
        );

        }

  Widget _mainContext(BuildContext context) {
    var children2 = <Widget>[
               SizedBox(height: 60),
               Padding(
                 padding:const EdgeInsets.all(24.0),
                 
                 
               child:Text("",
                
               style: TextStyle(fontSize: 35 ,
               fontWeight: FontWeight.bold,
               color: Colors.white,
            )),
               
               ),
  
         
            Row (
                children: <Widget>[
                Padding(padding: EdgeInsets.all(20.0),),
                 Expanded(

                       child: CustomButton(
                          onPressed: (){
                            Navigator.of(context).pushNamed("taskPage");
                         _pageController.previousPage(
                           duration:Duration(milliseconds: 500),
                           curve:Curves.bounceInOut);
                       },
                      buttonText: "Task",
                      
                       color:
                       currentPage < 0.5 ? Theme.of(context).accentColor:Colors.white,
                       textColor:
                        currentPage <0.5? Colors.black: Theme.of(context).accentColor,
                      
                   ),
                     ),
                 
                 SizedBox(
                   width: 32,
                 ),

                  Expanded(
                     child: CustomButton(
                         onPressed: (){
                            Navigator.of(context).pushNamed("eventPage");
                           _pageController.nextPage(
                           duration:Duration(milliseconds: 500),
                           curve:Curves.bounceInOut);
                         },
                     buttonText: "Events",

                     color:
                     currentPage > 0.5 ? Theme.of(context).accentColor:Colors.white,
                     textColor:
                        currentPage >0.5? Colors.black: Theme.of(context).accentColor,
                     
                   
          
                    ),
                    ),
                SizedBox(
                    width:32 ,)
               ],
               ),
               ];
    return Column(
        children: <Widget>[  

        ClipPath (
          clipper: Myclipper(),
           child: Container(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: children2,
               ),
                
            height:250 ,
            decoration: BoxDecoration(
            color:Colors.deepPurple[400] ),
              ),
                ),
          
        Expanded(
        child: PageView(
          controller: _pageController,
          children: <Widget>[
          TaskPage(),EventPage()],
        )),

             
             
      ],
     );
 
  }

}

   class Myclipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path =new Path();
      path.lineTo(0, size.height-70);
      var controllPoint=Offset(50,size.height);
      var endPoint=Offset(size.width/2, size.height);
      path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      return path;    
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
  
    return true;
  }
        
      }