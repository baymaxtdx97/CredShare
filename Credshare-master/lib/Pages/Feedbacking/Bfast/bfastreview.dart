import 'package:flutter/material.dart';
import 'package:credshare/Pages/Feedbacking/Bfast/chinese_feedback_reviews.dart' as first;
import 'package:credshare/Pages/Feedbacking/Bfast/malay_feedback_reviews.dart' as third;
import 'package:credshare/Pages/Feedbacking/Bfast/western_feedback_reviews.dart' as second;
import 'package:credshare/Pages/Feedbacking/Bfast/noodle_feedback_reviews.dart' as four;
import 'package:credshare/Pages/Feedbacking/Bfast/vegetarian_feedback_reviews.dart' as five;

class Bfast extends StatefulWidget{
  @override
  BfastState createState()=> new BfastState();
}

class BfastState extends State<Bfast> with SingleTickerProviderStateMixin{
  TabController controller;
  @override
  void initState(){
    super.initState();
    controller= new TabController(vsync:this,length:5);
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Align(
            alignment: Alignment(-0.3, 0),
            child: Text('Feedback',
              style: TextStyle(fontStyle: FontStyle.italic,
                  color: Colors.white,
                  fontSize: 20.0
              ),
            )
        ),
        backgroundColor: Colors.blueGrey,
        bottom: new TabBar(
          controller: controller,
            tabs: <Tab>[
              new Tab(text: "Chinese",),
              new Tab(text: "Western"),
              new Tab(text: "Malay"),
              new Tab(text: "Noodle"),
              new Tab(text: "Vegetarian"),

            ]
        ),
      ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new first.ChineseReview(user:null),
            new second.WesternReview(user:null),
            new third.MalayReview(user:null),
            new four.NoodlesReview(user:null),
            new five.VegetarianReview(user:null)
          ],
        )
    );
  }
}