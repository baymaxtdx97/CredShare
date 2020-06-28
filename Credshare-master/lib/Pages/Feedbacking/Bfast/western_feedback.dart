import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/Feedbacking/feedback_main.dart';
import 'package:credshare/Pages/new_home.dart';

class WesternPage extends StatefulWidget {
  const WesternPage({
    Key key,
    @required this.user
  }): super(key: key);
  final FirebaseUser user;
  @override
  _WesternPageState createState() => new _WesternPageState();
}

class _WesternPageState extends State<WesternPage> {
  String _stars, _content;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2d386b),
      body: new Stack(
        fit:StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/sharess.jpg"),
            fit: BoxFit.cover,
          ),
          new Center(
              child: ListView(
                children: <Widget>[
                  SizedBox(height:50),
                  new Form(
                    key: _formKey,
                    child:new Theme(
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
                      ) ,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (input) {
                                if(input.isEmpty){
                                  return 'Please give a rating';
                                }else if(int.parse(input)>5){
                                  return 'Maximum is 5';
                                }
                              },
                              style: new TextStyle(color:Color(0xff2d386b)),
                              onSaved: (input) => _stars = input,
                              keyboardType: TextInputType.number,
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                              decoration: new InputDecoration(
                                  hintText: "Ratings out of 5",
                                hintStyle: new TextStyle(color:Color(0xff2d386b)),
                              ),
                            ),
                          ),
                          SizedBox (height: 5.0),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (input){
                                if (input.isEmpty){
                                  return 'Please give a review';
                                }else if (input.length<40){
                                  return 'Please give a review of minimum 40 characters long';
                                }
                              },
                              style: new TextStyle(color:Color(0xff2d386b)),
                              onSaved: (input) => _content = input,
                              decoration: new InputDecoration(
                                hintText: "Review Section",
                                hintStyle: new TextStyle(color:Color(0xff2d386b)),
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 14,
                              textInputAction: TextInputAction.go,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:20.0),
                          ),
                          RaisedButton(
                            color:Colors.indigo,
                            textColor:Colors.white,
                            onPressed: reviewIn,
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    ) ,
                  ),
                ],
              )
          )
        ],
      ),
    );
  }
  Future<void> reviewIn() async {
    final formState = _formKey.currentState;
    if(formState.validate()) {
      formState.save();
      try {
        Firestore.instance.collection("bfast_reviews")
            .document("western")
            .updateData({"Western_rating": FieldValue.arrayUnion(
            [_stars+DateTime.now().toString()])});
        Firestore.instance.collection("bfast_reviews")
            .document("western")
            .updateData({"Western_review": FieldValue.arrayUnion(
            [_content+" "+ DateTime.now().toString()])});
        Navigator.push(context , MaterialPageRoute(
            builder: (context) => Home(user:widget.user) , fullscreenDialog: true));
        print(_stars);
      }
      catch (e) {
        print(e);
      }
    }
  }
}