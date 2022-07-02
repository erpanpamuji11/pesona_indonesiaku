import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseServices {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
}
