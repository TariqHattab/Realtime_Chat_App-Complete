import 'package:chat_app/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _auth = FirebaseAuth.instance;
  _submitAuthForm(Map userData, bool isLogin) async {
    AuthResult authResult;
    try {
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: userData['email'],
          password: userData['password'],
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: userData['email'],
          password: userData['password'],
        );
      }
    } on PlatformException catch (e) {
      var message = 'An error occured, please check your credentials';
      if (e.message != null) {
        message = e.message;
      }
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm),
    );
  }
}
