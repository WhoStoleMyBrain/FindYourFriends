import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRegisterPage extends StatefulWidget {
  const LoginRegisterPage({super.key});

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerUserName = TextEditingController();
  Timer? _debounce;
  bool usernameAvailable = true;
  User? user;

  @override
  void dispose() {
    _debounce?.cancel();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerUserName.dispose();
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPasswordAndUsername() async {
    if (!_validUserName(_controllerUserName.text)) {
      return;
    }
    try {
      await Auth()
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text)
          .whenComplete(() => user = Auth().currentUser);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
    var batch = FirebaseFirestore.instance.batch();
    var userDoc = FirebaseFirestore.instance.doc('users/${user?.uid}');
    var usernameDoc =
        FirebaseFirestore.instance.doc('usernames/${_controllerUserName.text}');
    batch.set(userDoc, {'username': _controllerUserName.text});
    batch.set(usernameDoc, {'uid': user?.uid});
    await batch.commit();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _entryField(String title, TextEditingController controller,
      {Function(String)? inputChanged}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
      onChanged: inputChanged,
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _usernameExistsMessage() {
    return Text(
      usernameAvailable ? 'Username Available' : 'Username not available',
      style: TextStyle(color: usernameAvailable ? Colors.green : Colors.red),
    );
  }

  Widget _submitButton() {
    return ElevatedButton(
        onPressed: isLogin
            ? signInWithEmailAndPassword
            : createUserWithEmailAndPasswordAndUsername,
        child: Text(isLogin ? 'Login' : 'Register'));
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ? 'Register instead' : 'Login instead'));
  }

  bool _validUserName(String username) {
    return username.length >= 3 && username.length <= 15;
  }

  void _checkUsernameAvailable(String username) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      var username = _controllerUserName.text;
      if (_validUserName(username)) {
        var ref = FirebaseFirestore.instance.doc('usernames/$username');
        var documentSnapshot = await ref.get();
        setState(() {
          usernameAvailable = !documentSnapshot.exists;
        });
      }
    });
  }

  List<Widget> _usernameFields() {
    if (!isLogin) {
      return [
        _entryField(
          'username',
          _controllerUserName,
          inputChanged: _checkUsernameAvailable,
        ),
        _usernameExistsMessage(),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: _title()),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            ..._usernameFields(),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
