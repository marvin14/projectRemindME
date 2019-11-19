import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/pages/calendar.dart';
import 'package:project/pages/event_page.dart';
import 'package:project/pages/landing_page.dart';
import 'package:project/pages/task_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'RemindMe',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        home: UserLogin(),
        routes: <String, WidgetBuilder>{
          "/taskPage": (BuildContext context) => TaskPage(),
          "/eventPage": (BuildContext context) => EventPage(),
          "/calendar": (BuildContext context) => HomePage(),
          "/landing": (BuildContext context) => MyHomePage(),
        });
  }
}

class UserLogin extends StatefulWidget {
  @override
  _UserLoginState createState() => _UserLoginState();
}

enum FormType { login, register }

class _UserLoginState extends State<UserLogin> {
  TextEditingController emailEditingContrller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validate() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.push(context, MaterialPageRoute(builder:(context)=>MyHomePage() ));
      return true;
    }
    return false;
  }

  void validateSubmit() async {
    if (validate()) {
      try {
        if (_formType == FormType.login){
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
        print('Signed in: ${user.uid}');
      }else{
        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)) as FirebaseUser;
        print('Registered user:${user.uid}');      
      }
      } catch (e) {
        print('Error:$e');
      }
    }
  }
  
  void register() {
   _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void login(){
    _formKey.currentState.reset();
    setState(() {
     _formType =FormType.login; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).accentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(padding: EdgeInsets.all(20)),
            Text(
              "RemindMe",
              style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: buildInputs()+submitButtons(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        validator: (value) => value.isEmpty ? 'Email Required' : null,
        decoration: InputDecoration(
          labelText: 'Email or Phone',
        ),
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password Required' : null,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> submitButtons() {
    if (_formType== FormType.login){
    return [
      RaisedButton(
        onPressed: validateSubmit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Theme.of(context).accentColor,
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
      FlatButton(
        child: Text('Create account'),
        onPressed: register,
      )
    ];
  }else{
     return [
      RaisedButton(
        onPressed: validateSubmit,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Theme.of(context).accentColor,
        child: Text(
          "Create account",
          style: TextStyle(color: Colors.white),
        ),
      ),
      FlatButton(
        child: Text('Have an account? Login'),
        onPressed: login,
      )
     ];
  }
}
}