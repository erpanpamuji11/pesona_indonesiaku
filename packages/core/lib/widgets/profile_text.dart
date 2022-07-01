
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget profileText() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users-form-data')
        .doc(currentUser!.email)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      var data = snapshot.data;
      if (data == null) {
        return const Text('World');
      }
      return Text(
        '${data['name']}',
        style: const TextStyle(
          color: Colors.lightBlue,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      );
    },
  );
}

Widget profileNameTitle() {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = _auth.currentUser;

  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users-form-data')
        .doc(currentUser!.email)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      var data = snapshot.data;
      if (data == null) {
        return const Text('Hallo World!', style: TextStyle(color: Colors.white),);
      }
      return Text(
        'Hallo ${data['nickName']}!',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
      );
    },
  );
}