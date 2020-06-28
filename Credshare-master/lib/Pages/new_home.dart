import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/all_recent.dart';
import 'package:credshare/Pages/Expire/main_expiry.dart';
import 'package:credshare/Pages/Sharing/main_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:credshare/Pages/Feedbacking/main_feedback.dart';
import 'package:credshare/Pages/Setup/signIn.dart';


class Home extends StatelessWidget {
  const Home({
    Key key,
    @required this.user
  }): super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context){
  return WillPopScope(
    onWillPop: ()async=>false,
    child: Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children:<Widget>[
          new Image(
            image: new AssetImage("assets/homes.png"),
            fit: BoxFit.cover,
          ),

         StreamBuilder(
          stream:Firestore.instance.collection("users").document(user.uid).snapshots(),
          builder: (context,snapshot){
            if (!snapshot.hasData)
              return Center(child: Text ('Loading data... Please Wait...',style: TextStyle(fontStyle: FontStyle.italic,color: Color(0xff2d386b)),));
            return new ListView(
              children: <Widget>[
                new Container(
                    child: new Column(
                      children: <Widget>[
                        new Text("CredShare",
                            style: TextStyle(fontStyle: FontStyle.italic,
                                fontSize: 20.0)
                        ),
                        new Container(
                          height: 80.0,
                          decoration: new BoxDecoration(
                              color: Colors.transparent
                          ),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new MaterialButton(
                                      child: new Icon(
                                        Icons.compare_arrows,
                                        color: Color(0xff2d386b),
                                        size: 40.0,
                                      ),
                                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MainShare(user: user), fullscreenDialog: true));}
                                  ),
                                  new Text("Share", style: new TextStyle(
                                      color: Color(0xff2d386b),
                                      fontWeight: FontWeight.w500))
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  MaterialButton(
                                    child:new Icon(
                                      Icons.feedback,
                                      color: Color(0xff2d386b),
                                      size: 40.0,
                                    ),
                                    onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MainFeedback(user: user), fullscreenDialog: true));}
                                  ),
                                  new Text("Feedback",style: new TextStyle(
                                  color:  Color(0xff2d386b),
                                      fontWeight: FontWeight.w500
                                  )
                                  )
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  MaterialButton(
                                      child: new Icon(
                                        Icons.perm_identity,
                                        color: Color(0xff2d386b),
                                        size: 40.0,
                                      ),
                                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MainExpiry(user: user), fullscreenDialog: true));}
                                  ),
                                  new Text("Expiry", style: new TextStyle(
                                      color: Color(0xff2d386b),
                                      fontWeight: FontWeight.w500)
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Divider(color: Colors.black38
                        ),
                        SizedBox(height: 10.0),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Container(
                              height: 58.0,
                              decoration: new BoxDecoration(
                                  color: Colors.transparent
                              ),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: new Column(
                                  children: <Widget>[
                                    new Text("Breakfast Balance:", style: new TextStyle(
                                        color: Color(0xff2d386b),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),),
                                    SizedBox(height: 5.0),
                                    new Text((snapshot.data['breakfast_credits_expiry'].length + snapshot.data['breakfast_credits_shared'].length).toString(), style: new TextStyle(
                                        color: Color(0xff2d386b),
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w700),
                                      textAlign: TextAlign.start,),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 140.0),
                            new Container(
                              height: 60.0,
                              decoration: new BoxDecoration(
                                  color: Colors.transparent
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: new Column(
                                  children: <Widget>[
                                    new Text("Dinner Balance:", style: new TextStyle(
                                        color: Color(0xff2d386b),
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500)),
                                    SizedBox(height: 5.0),
                                    new Text((snapshot.data['dinner_credits_expiry'].length + snapshot.data['dinner_credits_shared'].length).toString(), style: new TextStyle(
                                        color: Color(0xff2d386b),
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: new Text ("Recent Transactions",
                                      style: new TextStyle(color: Color(0xff2d386b),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500))
                              ),
                              Align(
                                alignment:Alignment.topRight,
                                child: GestureDetector(
                                    child: Text("See all >",
                                      style: TextStyle(fontSize: 16.0,
                                        color: Color(0xff2d386b),
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),
                                 onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => RecentPage(user: user), fullscreenDialog: true));})
                              )
                            ],
                          ),
                        ),
                        SizedBox(height:10),
                        new Container(
                          height: 250,
                          decoration: new BoxDecoration(
                              color: Colors.transparent
                          ),
                          child: ListView.builder(
                            itemBuilder: (context, position) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                            const EdgeInsets.all(2),
                                            child: Text(
                                              snapshot.data["recent_transactions_name"][position].toString().substring(0,9),
                                              style: TextStyle(
                                                  fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                              snapshot.data["recent_transactions_date"][position].toString().substring(0,24),
                                              style: TextStyle(fontSize: 12.0,color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            Text(
                                              snapshot.data["recent_transactions_credits"][position].toString().substring(0, snapshot.data["recent_transactions_credits"][position].toString().length - DateTime.now().toString().length),
                                              style: TextStyle(color: Colors.white),
                                            ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 2.0,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height:13)
                                ],
                              );
                            },
                            itemCount:  (snapshot.data["recent_transactions_name"].length==null)? 0: (snapshot.data["recent_transactions_name"].length >5)? 5:snapshot.data["recent_transactions_name"].length
                          ),
                        ),
                        new RaisedButton(
                            color:Color(0xff2d386b),
                            textColor:Colors.white,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.input,
                                  color: Colors.white,
                                ),
                                SizedBox(width:130),
                                Text(
                                  "Logout"
                                )
                              ],
                            ),
                            onPressed: ()async {_signOut(); Navigator.push(context , MaterialPageRoute(
                                builder: (context) => LoginPage() , fullscreenDialog: true));}
                            )
                      ],
                    )
                ),
              ],
            );
          },
        ),
      ],
      ),
    ),
  );
  }
  Future <LoginPage> _signOut()  async{
      await FirebaseAuth.instance.signOut();
      return LoginPage();

  }

}