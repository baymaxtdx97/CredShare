import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/chinese_feedback2.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/malay_feedback2.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/western_feedback2.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/indian_feedback2.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/noodle_feedback2.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/vegetarian_feedback2.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/dinner_review.dart';

class ReviewsPage extends StatelessWidget{
  const ReviewsPage({
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
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MalayPage2(user:user), fullscreenDialog: true));},
                  child: Text('Malay'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ChinesePage2(user:user), fullscreenDialog: true));},
                  child: Text('Chinese'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => WesternPage2(user:user), fullscreenDialog: true));},
                  child: Text('Western'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => VegetarianPage2(user:user), fullscreenDialog: true));},
                  child: Text('Vegeterian'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NoodlePage2(user:user), fullscreenDialog: true));},
                  child: Text('Noodle'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => IndianPage(user:user), fullscreenDialog: true));},
                  child: Text('Indian'),
                ),
              ),
              SizedBox(height:100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  color:Colors.indigo,
                  textColor:Colors.white,
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Dinner(), fullscreenDialog: true));},
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