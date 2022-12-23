import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/utils.dart';

import 'image_scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String translateText = '';

  @override
  Widget build(BuildContext context) {
    Future<void> getTranslate(String text) async {
      final result = await textTranslate(text);
      setState(() {
        translateText = result;
      });
    }

    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Recognize'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImageScanScreen()),
                );
              },
              child: Text('To Image'),
            ),
            Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: TextField(
                  onChanged: (text) {
                    getTranslate(text);
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Write something'),
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 150,
              ),
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  translateText == "" ? "Translate goes here" : translateText),
            ),
          ],
        ),
      ),
    );
  }
}
