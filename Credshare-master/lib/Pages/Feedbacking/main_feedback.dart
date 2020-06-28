import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/Feedbacking/feedback_main.dart';
import 'package:credshare/Pages/new_home.dart';
import 'package:credshare/Pages/Feedbacking/feedback_main2.dart';


class MainFeedback extends StatelessWidget {
  const MainFeedback({
    Key key,
    @required this.user
  }): super(key: key);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children:<Widget>[
          new Image(
            image: new AssetImage("assets/homes.png"),
            fit: BoxFit.cover,
          ),
          StreamBuilder( stream:Firestore.instance.collection("users").document(user.uid).snapshots(),
            builder: (context,snapshot) {
              if (!snapshot.hasData)
                return Center(child: Text ('Loading data... Please Wait...',style: TextStyle(fontStyle: FontStyle.italic,color: Color(0xff2d386b)),));
              return new ListView(
                children: <Widget>[
                  SizedBox(height:200),
                  new Container(
                    height: 80.0,
                    decoration: new BoxDecoration(
                        color: Colors.transparent
                    ),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new MaterialButton(
                                child: new Icon(
                                  Icons.wb_sunny,
                                  color: Color(0xff2d386b),
                                  size: 40.0,
                                ),
                                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage(user: user), fullscreenDialog: true));}
                            ),
                            new Text("Breakfast", style: new TextStyle(
                                color: Color(0xff2d386b),
                                fontWeight: FontWeight.w500))
                          ],
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new MaterialButton(
                                child: new Icon(
                                  Icons.brightness_3,
                                  color: Color(0xff2d386b),
                                  size: 40.0,
                                ),
                                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewsPage(user:user), fullscreenDialog: true));}
                            ),
                            new Text("Dinner", style: new TextStyle(
                                color: Color(0xff2d386b),
                                fontWeight: FontWeight.w500))
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}