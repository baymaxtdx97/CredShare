import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credshare/Pages/new_home.dart';

class RecentPage extends StatelessWidget {
  const RecentPage({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
              color:Color(0xff2d386b)
          ),
          backgroundColor: Colors.white70,
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/sharess.jpg"),
            fit: BoxFit.cover,
          ),
          Center(
            child: StreamBuilder(
              stream:Firestore.instance.collection("users").document(user.uid).snapshots(),
              builder: (context,snapshot) {
                if (!snapshot.hasData)
                  return Center(child: Text ('Loading data... Please Wait...',style: TextStyle(fontStyle: FontStyle.italic,color: Color(0xff2d386b)),));
                return Container(
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
                                            fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff2d386b)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(
                                        snapshot.data["recent_transactions_date"][position].toString().substring(0,24),
                                        style: TextStyle(fontSize: 14.0,color: Color(0xff2d386b)),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                  Text(
                                    snapshot.data["recent_transactions_credits"][position].toString().substring(0, snapshot.data["recent_transactions_credits"][position].toString().length - DateTime.now().toString().length),
                                    style: TextStyle(color: Color(0xff2d386b)),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Color(0xff2d386b),
                            ),
                            SizedBox(height:13)
                          ],
                        );
                      },
                      itemCount: snapshot.data["recent_transactions_name"].length
                  ),
                );
              },
            ),
          )
        ] ,
      ),
    );
  }
}