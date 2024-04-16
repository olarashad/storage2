import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirestoreImageDisplay(),
  ));
}

class FirestoreImageDisplay extends StatefulWidget {
  const FirestoreImageDisplay({super.key});

  @override
  State<FirestoreImageDisplay> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FirestoreImageDisplay> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();

    imageUrl = '';
    getImageUrl();
  }

  Future<void> getImageUrl() async {
    final ref = storage.ref().child('3.1Compressed.jpg');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display image from Firebase Storage"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Image(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
