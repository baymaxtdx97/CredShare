import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/Feedbacking/Bfast/bfastreview.dart';
import 'package:credshare/Pages/Feedbacking/Bfast/chinese_feedback.dart';
import 'package:credshare/Pages/Feedbacking/Bfast/malay_feedback.dart';
import 'package:credshare/Pages/Feedbacking/Bfast/western_feedback.dart';
import 'package:credshare/Pages/Feedbacking/Bfast/vegetarian_feedback.dart';
import 'package:credshare/Pages/Feedbacking/Bfast/noodle_feedback.dart';

class ReviewPage extends StatelessWidget{
  const ReviewPage({
    Key key,
    @required this.user
  }): super(key: key);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color:Color(0xff2d386b)
        ),
        backgroundColor: Colors.white70,
        title: Align(
          alignment: Alignment(-0.3,0),
          child: Text ('Feedback',
            style: TextStyle(fontStyle: FontStyle.italic,
                color: Color(0xff2d386b),
                fontSize: 20.0
            ),
          ),
        )
    ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/homes.png"),
            fit: BoxFit.cover,
          ),
          new Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MalayPage(user:user), fullscreenDialog: true));},
                  child: Text('Malay'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ChinesePage(user: user), fullscreenDialog: true));},
                  child: Text('Chinese'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => WesternPage(user:user), fullscreenDialog: true));},
                  child: Text('Western'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => VegetarianPage(user:user), fullscreenDialog: true));},
                  child: Text('Vegeterian'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NoodlePage(user:user), fullscreenDialog: true));},
                  child: Text('Noodle'),
                ),
              ),
              SizedBox(height:150),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Bfast(), fullscreenDialog: true));},
                  child: Text('See all reviews'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}