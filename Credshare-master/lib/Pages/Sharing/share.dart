import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/new_home.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class SharingPage extends StatefulWidget {
  const SharingPage({
    Key key ,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;
  @override
  _SharingPageState createState() => new _SharingPageState();
}


class _SharingPageState extends State<SharingPage> {
  String _receiver , _number,_receiver2;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context)  {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(
                color:Color(0xff2d386b)
            ),
            backgroundColor: Colors.grey,
            title: Align(
              alignment: Alignment(-0.3,0),
              child: Text ('Share',
                style: TextStyle(fontStyle: FontStyle.italic,
                    color: Color(0xff2d386b),
                    fontSize: 20.0
                ),
              ),
            )
        ),
      body:Stack(
        fit: StackFit.expand,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/sharess.jpg"),
              fit: BoxFit.cover,
            ),
            Center(
              child: StreamBuilder(
            stream:Firestore.instance.collection("users").document(widget.user.uid).snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData)
                return Center(child: Text ('Loading data... Please Wait...',style: TextStyle(fontStyle: FontStyle.italic,color: Color(0xff2d386b)),));
              return ListView(
                children: <Widget>[
                  SizedBox(height: 50) ,
                  new Form(
                    key: _formKey ,
                    child: new Theme(
                      data: new ThemeData(
                          brightness: Brightness.dark ,
                          primarySwatch: Colors.blueGrey ,
                          inputDecorationTheme: new InputDecorationTheme(
                              labelStyle: new TextStyle(
                                  color: Color(0xff2d386b) ,
                                  fontSize: 15.0 ,
                                  fontStyle: FontStyle.italic ,
                                  fontWeight: FontWeight.w700
                              )
                          )
                      ) ,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(8.0) ,
                            child: TextFormField(
                              onSaved: (input) => _number = input ,
                              style: new TextStyle(color:Color(0xff2d386b)),
                              // ignore: missing_return
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please give a number';
                                // ignore: missing_return,
                                } else if (int.parse(input)+ snapshot.data['breakfast_credits_used']>3) {
                                  return 'You have exceeded your allowed amount by '
                                      + (int.parse(input)+snapshot.data['breakfast_credits_used']-3).toString();
                                }
                              } ,
                              keyboardType: TextInputType.number ,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ] ,
                              decoration: new InputDecoration(
                                  hintText: "Number_of_Credits",
                                hintStyle: new TextStyle(color:Color(0xff2d386b)),
                              ) ,
                            ) ,
                          ) ,
                          SizedBox(height: 5.0) ,
                          Container(
                            margin: EdgeInsets.all(8.0) ,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (input) {
                                if (input.isEmpty) {
                                  return 'Please input an ID';
                                } else if (snapshot.data["users"][input]==null) {
                                  return 'User is not found';
                                }
                              } ,
                              onSaved: (input) => _receiver = input,
                                style: new TextStyle(color:Color(0xff2d386b)),
                              decoration: new InputDecoration(
                                hintText: "Receiver" ,
                                hintStyle: new TextStyle(color:Color(0xff2d386b)),
                            )
                            ) ,
                          ) ,
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0) ,
                          ) ,
                          RaisedButton(
                            color: Colors.indigo ,
                            textColor: Colors.white ,
                            onPressed: ()async {
                              final formState= _formKey.currentState;
                              if (formState.validate()) {
                                formState.save();
                                try{
                                  _receiver2= snapshot.data["users"][_receiver];
                                  var counter= int.parse(_number);
                                  var counting=0;
                                  print (int.parse(_number));
                                  while(counter>0){
                                    print("hello");
                                    Firestore.instance.collection("users").document(_receiver2).updateData(
                                        {"breakfast_credits_shared": FieldValue.arrayUnion([snapshot.data["breakfast_credits_expiry"][counting]])});
                                    Firestore.instance.collection("users").document(widget.user.uid).updateData(
                                        {"breakfast_credits_expiry":FieldValue.arrayRemove([snapshot.data["breakfast_credits_expiry"][counting]])});
                                    counter-=1;
                                    counting+=1;
                                  }
                                  print ("Safe");
                                  Firestore.instance.collection("users").document(widget.user.uid).updateData(
                                      {"breakfast_credits_used": FieldValue.increment(int.parse(_number))});
                                  // Below is the updating of recent

                                  Firestore.instance.collection("users").document(widget.user.uid).updateData(
                                      {"recent_transactions_credits": FieldValue.arrayUnion(
                                      ["-"+_number+" Breakfast"+ " "+DateTime.now().toString()])});

                                  Firestore.instance.collection("users").document(widget.user.uid).updateData(
                                      {"recent_transactions_date": FieldValue.arrayUnion(["Sent on "+DateTime.now().toString()])});

                                  Firestore.instance.collection("users").document(widget.user.uid).updateData(
                                      {"recent_transactions_name": FieldValue.arrayUnion([_receiver+ " "+DateTime.now().toString() ])});
                                  // Below is the receiver side

                                  Firestore.instance.collection("users").document(_receiver2).updateData(
                                      {"recent_transactions_credits": FieldValue.arrayUnion([
                                        "+"+_number+" Breakfast"+ " "+DateTime.now().toString()])});

                                  Firestore.instance.collection("users").document(_receiver2).updateData(
                                      {"recent_transactions_date": FieldValue.arrayUnion(["Received on "+DateTime.now().toString()])});

                                  Firestore.instance.collection("users").document(_receiver2).updateData(
                                      {"recent_transactions_name": FieldValue.arrayUnion(
                                          [snapshot.data["matriculation_number"].toString() + " " + DateTime.now().toString()])});

                                  Navigator.push(context , MaterialPageRoute(
                                      builder: (context) => Home(user: widget.user) ,
                                      fullscreenDialog: true));
                                } catch (e){
                                  print (e);
                                }
                            }
                            },
                            child: Text('OK') ,
                          ) ,
                        ] ,
                      ) ,
                    ) ,
                  ) ,
                ] ,
              );
            },
            ),
            )
          ] ,
      )
    );
  }

}

