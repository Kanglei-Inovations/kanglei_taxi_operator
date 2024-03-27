import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kanglei_taxi_operator/conts/firebase/firestore_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ChatProvider(
      {required this.prefs,
        required this.firebaseStorage,
        required this.firebaseFirestore});

  UploadTask uploadImageFile(File image, String fileName, String id) {
    final path = 'messages/${id}/${fileName}';
    Reference reference = firebaseStorage.ref().child(path);
    UploadTask uploadTask = reference.putFile(image);
    return uploadTask;
  }

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  Stream<QuerySnapshot> getChatMessage(String userid, int limit) {
    return firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)

      .orderBy(FirestoreConstants.date, descending: true)
      .limit(limit)
      .snapshots();
  }

  void sendChatMessage(String content, String type, String userId) {
    firebaseFirestore
        .collection(FirestoreConstants.pathMessageCollection)
      .add({
  'userId': userId,
  'date': DateTime.now(),
  'message': content,
  'replydate' : DateTime.now(),
  'reply' : '',
      'type': type,
  // Add file information here if applicable
  });

  }
}

class MessageType {
  static const text = "text";
  static const image = "img";
  static const sticker = "stk";
}