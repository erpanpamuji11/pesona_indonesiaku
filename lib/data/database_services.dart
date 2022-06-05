import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:pesona_indonesiaku_app/data/models/wisata_model.dart';

class DatabaseServices {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;

  static Future<DocumentSnapshot> getWisata(String id) async {
    return await FirebaseFirestore.instance.collection("wisata").doc(id).get();
  }

  static Stream<List<Wisata>> readWisata() => FirebaseFirestore.instance
      .collection('wisata')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Wisata.fromJson(doc.data())).toList());
}
