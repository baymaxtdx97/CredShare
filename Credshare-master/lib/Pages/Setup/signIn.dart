import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:credshare/Pages/new_home.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}



class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin{
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation ;

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override

  void initState(){
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration (milliseconds:1000)
    );
    _iconAnimation= new CurvedAnimation(
        parent:_iconAnimationController,
        curve: Curves.easeOut
    );
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        fit:StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/login.jpg"),
            fit: BoxFit.cover,
          ),

         Center(
           child: SingleChildScrollView(
             child: Container(
               width:400,
               height:400,
               child: new Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   new Icon(
                     Icons.account_circle,
                     color: Colors.white70,
                     size: _iconAnimation.value *100,
                   ),

                  Form(
                  key: _formKey,
                  child: new Theme(
                    data: new ThemeData(
                        brightness: Brightness.dark,
                        primarySwatch: Colors.blueGrey,
                        inputDecorationTheme: new InputDecorationTheme(
                            labelStyle: new TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700
                            )
                        )
                    ),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          validator: (input) {
                            if(input.isEmpty){
                              return 'Please type in an username';
                            }
                          },
                          onSaved: (input) => _email = input,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0),),
                              hintText: 'Username',
                          ),
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                          ),
                        ),
                        SizedBox (height: 5.0),
                        TextFormField(
                          validator: (input) {
                            if(input.isEmpty ){
                              return 'Please type in a password';
                            }
                            else if (input.length<6){
                              return "Password has to be 6 characters long";
                            }
                          },
                          onSaved: (input) => _password = input,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                              hintText: 'Password'
                          ),
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white70,
                          ),
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20.0),
                        ),
                        RaisedButton(
                          color:Colors.indigo,
                          textColor:Colors.white,
                          onPressed: signIn,
                          child: Text('Sign In'),
                        ),

                      ],
                    ),
                  ),

                    ),
                    ]
               ),
             ),
           ),
         ),

        ],
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);

        Navigator.push(context, MaterialPageRoute(builder: (context) => Home(user: user), fullscreenDialog: true));
        //TODO: Navigate to home

      }
      catch(e){
        return _ackAlert(context);
      }
    }
  }

}


// Below is the pop up feature
Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('Username/Password is incorrect',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
        ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok',
            style: TextStyle(
              color: Colors.black87,
            ),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}