import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/Feedbacking/feedback_main.dart';


class Chinese2Review extends StatelessWidget {
  const Chinese2Review({
    Key key,
    @required this.user
  }): super(key: key);
  final FirebaseUser user;
  @override
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/sharess.jpg"),
            fit: BoxFit.cover,
          ),
          StreamBuilder(
              stream:Firestore.instance.collection("dinner_reviews").document("chinese").snapshots(),
              builder: (context,snapshot){
                if (!snapshot.hasData)
                  return Center(child: Text ('Loading data... Please Wait...',style: TextStyle(fontStyle: FontStyle.italic,color: Color(0xff2d386b)),));
                return new Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent
                  ),
                  child: new ListView.builder(
                    itemBuilder: (context,position){
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.all(2),
                            child: Text(snapshot.data["Chinese_rating"][position].toString().substring(0,1) + "/5",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff2d386b)),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.all(2),
                            child: Text(snapshot.data["Chinese_review"][position].toString().substring(0, snapshot.data["Chinese_review"][position].toString().length - DateTime.now().toString().length),
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff2d386b)),
                            ),
                          ),
                          Divider(
                            height: 2.0,
                            color: Color(0xff2d386b),
                          ),
                          SizedBox(height:13)
                        ],
                      );
                    },
                    itemCount: (snapshot.data["Chinese_rating"].length== null)? 0 : snapshot.data["Chinese_rating"].length,
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}