import 'package:flutter/material.dart';
import 'package:credshare/Pages/Setup/signIn.dart';
import 'package:credshare/Pages/Sharing/share.dart';


void main() => runApp(CredShare());

class CredShare extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CredShare',
      home: LoginPage(),
      routes: <String, WidgetBuilder> {
        '/LoginPage' : (BuildContext context) => new LoginPage(),
      }
      );
  }
}


