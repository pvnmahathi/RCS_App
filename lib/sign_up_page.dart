// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// @dart=2.9

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
String Name;
String Branch;
String RegNo;
String Univ;
String EmailId;
/// Entrypoint example for registering via Email/Password.
class RegisterPage extends StatefulWidget {
  /// The page title.
  final String title = 'Registration';

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _UnivController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  CollectionReference users_db = FirebaseFirestore.instance.collection('Users Database');
  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users_db
        .add({
      'Name': Name,
      'University': Univ,
      'Branch': Branch,
      'Registration Number': RegNo,
      'Email Id': EmailId,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

  }


  bool _success;
  String _userEmail = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
          key: _formKey,
          child: Card(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                      controller: _nameController,decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do people call you?',
                    labelText: 'Name *',
                  )),
                  TextFormField(
                      controller: _UnivController,decoration: const InputDecoration(
                    icon: Icon(Icons.school),
                    hintText: 'University',
                    labelText: 'University*',
                  )),
                  TextFormField(
                      controller: _branchController,decoration: const InputDecoration(
                    icon: Icon(Icons.book),
                    hintText: 'Branch',
                    labelText: 'Branch*',
                  )),
                  TextFormField(
                      controller: _regNoController,decoration: const InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    hintText: 'Your University roll number',
                    labelText: 'Registration Number *',
                  )),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email),labelText: 'Email'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.lock),labelText: 'Password'),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: 'Confirm your password',
                      labelText: 'Confirm Password*',
                    ),
                    autofocus: false,
                    obscureText: true,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    alignment: Alignment.center,
                    child: SignInButtonBuilder(
                      icon: Icons.person_add,
                      backgroundColor: Colors.blueGrey,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await _register();
                          Name = _nameController.text;
                          Univ = _UnivController.text;
                          RegNo = _regNoController.text;
                          Branch = _branchController.text;
                          EmailId = _emailController.text;

                          addUser();
                        }
                      },
                      text: 'Register',
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(_success == null
                        ? ''
                        : (_success
                            ? 'Successfully registered $_userEmail'
                            : 'Registration failed')),
                  )
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code for registration.
  Future<void> _register() async {
    print("registration initialized");
    print(_emailController.text);
    print(_passwordController.text);
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }
}

