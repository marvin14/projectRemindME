import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/pages/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

 
class UserLogin extends StatefulWidget {
   UserLogin({this.auth, this.onSignedIn});
   final BaseAuth auth;
   final VoidCallback onSignedIn;

  _UserLoginState createState() => _UserLoginState();
}

enum FormType { login, register }

class _UserLoginState extends State<UserLogin> {
  TextEditingController emailEditingContrller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;
  String _errorMessage;

      bool _isLoading;
 

  bool validate() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateSubmit() async {
    setState(() {
      _errorMessage="";
      _isLoading = true;

    });
    if (validate()) {
      try {
        if (_formType == FormType.login){
        String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;
        print('Signed in: $userId');
      }else{
        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
        FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        print('Registered user:$userId');      
      }
        widget.onSignedIn();

      } catch (e) {
        print('Error:$e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  void initState(){
    _errorMessage = "";
    _isLoading = false;
    super.initState();
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
      resizeToAvoidBottomInset: false,
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
                      showErrorMessage(),
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




  Widget showErrorMessage(){
    if(_errorMessage.length>0 && _errorMessage!=null){
      return Text(
        _errorMessage,
        style: TextStyle(
          fontSize:13.0,
          color: Colors.red,
          fontWeight: FontWeight.w300),);
    }else{
      return Container
      (height:0.0 ,);
    }
  }




  List<Widget> buildInputs() {
    return [
      TextFormField(
        validator: (value) => value.isEmpty ? 'Email Required' : null,
        decoration: InputDecoration(
          hintText: 'Email or Phone',
          icon: Icon(Icons.mail)
        ),
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password Required' : null,
        decoration: InputDecoration(
          hintText: 'Password',
          icon:Icon(Icons.lock)
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