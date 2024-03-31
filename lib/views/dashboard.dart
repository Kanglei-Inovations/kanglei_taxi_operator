
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController versionController = TextEditingController();
  String? filePath;
  late final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<void> uploadFile(BuildContext context) async {
    try {
      if (filePath == null) {
        // Show error message if no file is selected
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please select a file.'),
        ));
        return;
      }

      // Upload file to Firebase Storage
      String fileName = filePath!.split('/').last;
      final path = 'app/$fileName';
      Reference reference = firebaseStorage.ref().child(path);
      File file = File(filePath!);
      // Get download URL for the uploaded file
      await reference.putFile(file);
      // Get download URL for the uploaded file
      String fileUrl = await reference.getDownloadURL();
      // Get current date
      DateTime currentDate = DateTime.now();

      // Get version from text field
      String version = versionController.text;

      // Add file URL, date, and version to the database
      await FirebaseFirestore.instance.collection('app_links').add({
        'file_url': fileUrl,
        'upload_timestamp': Timestamp.fromDate(currentDate),
        'version': version,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('File uploaded successfully.'),
      ));

      // Clear the version field
      versionController.clear();
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading file: $e'),
      ));
    }
  }
  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
      allowedExtensions: ['apk'],);
    if (result != null) {
      PlatformFile file = result.files.first;
      filePath = file.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: selectFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: versionController,
              decoration: InputDecoration(
                labelText: 'Version',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => uploadFile(context),
              child: Text('Upload File'),
            ),
          ],
        ),
      ),
    );
  }
}
