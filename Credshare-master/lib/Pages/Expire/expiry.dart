import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpiryPage extends StatelessWidget{
  const ExpiryPage({
    Key key,
    @required this.user
  }): super(key: key);
  final FirebaseUser user;
  @override

  Widget build(BuildContext context){
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
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/sharess.jpg"),
            fit: BoxFit.cover,
          ),
          StreamBuilder(
          stream:Firestore.instance.collection("users").document(user.uid).snapshots(),
          builder: (context,snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text('Loading data... Please Wait...',
                style: TextStyle(
                    fontStyle: FontStyle.italic, color: Color(0xff2d386b)),));
            return Container(
                decoration: new BoxDecoration(
                    color: Colors.transparent
                ),
                child: ListView.builder(
                    itemBuilder: (context, position) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding:
                                const EdgeInsets.all(2),
                                child: Text("credit",
                                  style: TextStyle(
                                      fontSize: 16.0, fontWeight: FontWeight.bold,color: Color(0xff2d386b)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Text(
                                  snapshot.data["breakfast_credits_expiry"][position].toDate().toString() ,
                                  style: TextStyle(fontSize: 14.0,color: Color(0xff2d386b)),
                                ),
                              ),
                            ]
                        ),
                          Divider(
                            height: 2.0,
                            color: Color(0xff2d386b),
                          ),
                          SizedBox(height:13)
                        ]
                      );
                    },
                    itemCount: snapshot.data["breakfast_credits_expiry"].length
                )
            );
          }
          )
        ],
      ),
    );
  }
}


