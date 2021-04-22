import 'package:chat_app/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _auth = FirebaseAuth.instance;
  var _isLoading = false;
  _submitAuthForm(Map userData, bool isLogin, BuildContext ctx) async {
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
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
      await Firestore.instance
          .collection('users')
          .document(authResult.user.uid)
          .setData({
        'username': userData['username'],
        'email': userData['email'],
      });
    } on PlatformException catch (e) {
      var message = 'An error occured, please check your credentials';
      if (e.message != null) {
        message = e.message;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      _isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
