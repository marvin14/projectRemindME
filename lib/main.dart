import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/pages/add_event_page.dart';
import 'package:project/pages/add_task_page.dart';
import 'package:project/pages/event_page.dart';
import 'package:project/pages/task_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.deepPurple
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

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

    return Column(
        children: <Widget>[  

        ClipPath (
          clipper: Myclipper(),
           child: Container(
             
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
               SizedBox(height: 60),
               Padding(
                 padding:const EdgeInsets.all(24.0),
               child:Text("Monday",
                
               style: TextStyle(fontSize: 35 ,
               fontWeight: FontWeight.bold,
               color: Colors.white,
               ),
               ),
               ),
             
              Row (
                 children: <Widget>[
                Padding(padding: EdgeInsets.all(20.0),),
                 Expanded(

                  
                       child: MaterialButton(
                       shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12.0)),
                       color:
                       currentPage < 0.5 ? Theme.of(context).accentColor:Colors.white,
                       textColor:
                        currentPage <0.5? Colors.black: Theme.of(context).accentColor,
                
                       padding: const EdgeInsets.all(14.0),
                       child: Text("Task"),
                       onPressed: (){
                         _pageController.previousPage(
                           duration:Duration(milliseconds: 500),
                           curve:Curves.bounceInOut);
                          
                       },
                   ),
                     ),
                 
               
                 SizedBox(
                   width: 32,
                 ),

                  Expanded(
                     child: MaterialButton(
                     shape: RoundedRectangleBorder(
                    side: BorderSide(),
                     borderRadius: BorderRadius.circular(12.0)),
                     color:
                    currentPage > 0.5 ? Theme.of(context).accentColor:Colors.white,
                       textColor:
                        currentPage >0.5? Colors.black: Theme.of(context).accentColor,
                     padding: const EdgeInsets.all(14.0),
                     child: Text("Events",),
                     onPressed: (){
                      _pageController.nextPage(
                           duration:Duration(milliseconds: 500),
                           curve:Curves.bounceInOut);
                     },
                 ),
                  ),
                  SizedBox(
                    width:32 ,)
               ],
               ),
             ],
             ),
            
            height:300 ,
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