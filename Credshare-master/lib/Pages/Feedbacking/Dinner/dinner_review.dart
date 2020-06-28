import 'package:flutter/material.dart';
import 'package:credshare/Pages/Feedbacking/Dinner/chinese_feedback2_review.dart' as first;
import 'package:credshare/Pages/Feedbacking/Dinner/malay_feedback2_review.dart' as third;
import 'package:credshare/Pages/Feedbacking/Dinner/western_feedback2_review.dart' as second;
import 'package:credshare/Pages/Feedbacking/Dinner/noodle_feedback2_review.dart' as four;
import 'package:credshare/Pages/Feedbacking/Dinner/indian_feedback2_review.dart' as five;
import 'package:credshare/Pages/Feedbacking/Dinner/vegetarian_feedback2_review.dart' as six;

class Dinner extends StatefulWidget{
  @override
  DinnerState createState()=> new DinnerState();
}

class DinnerState extends State<Dinner> with SingleTickerProviderStateMixin{
  TabController controller;
  @override
  void initState(){
    super.initState();
    controller= new TabController(vsync:this,length:6);
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
                new Tab(text:"Indian"),
                new Tab(text: "Vegetarian"),

              ]
          ),
        ),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new first.Chinese2Review(user:null),
            new second.Western2Review(user:null),
            new third.Malay2Review(user:null),
            new four.Noodles2Review(user:null),
            new five.IndianReview(user:null),
            new six.Vegetarian2Review(user:null),
          ],
        )
    );
  }
}