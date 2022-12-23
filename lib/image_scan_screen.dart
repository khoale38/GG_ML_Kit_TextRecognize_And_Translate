import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/utils.dart';

class ImageScanScreen extends StatefulWidget {
  const ImageScanScreen({Key? key}) : super(key: key);

  @override
  State<ImageScanScreen> createState() => _ImageScanScreenState();
}

class _ImageScanScreenState extends State<ImageScanScreen> {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  String translateText = "";

  bool isTranslate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Text Recognition example"),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                if (!textScanning && imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (imageFile != null) Image.file(File(imageFile!.path)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.image,
                                  size: 30,
                                ),
                                Text(
                                  "Gallery",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                            shadowColor: Colors.grey[400],
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.camera_alt,
                                  size: 30,
                                ),
                                Text(
                                  "Camera",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey[600]),
                                )
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                textScanning
                    ? const CircularProgressIndicator()
                    : Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          minHeight: 150,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)),
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          scannedText,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                isTranslate
                    ? const CircularProgressIndicator()
                    : Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(
                          minHeight: 150,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue)),
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          translateText == "" ? "" : translateText,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
              ],
            )),
      ),
    );
  }

  void getImage(ImageSource source) async {
    setState(() {
      scannedText = "";
      translateText = "";
    });
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getText(imageFile!).then((value) => null);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
      setState(() {});
    }
  }

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<void> getText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final RecognizedText recognizedText = await textRecognizer
        .processImage(inputImage)
        .timeout(const Duration(seconds: 30));

    String text = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
          setState(() {
            scannedText = "$scannedText${element.text} ";
          });
        }
      }
    }

    if (text == "") {
      setState(() {
        scannedText = "No Text Founds";
        translateText = "Khong co van ban duoc tim thay";
      });
    } else {
      setState(() {
        isTranslate = true;
      });
      translateText = await textTranslate(scannedText);
      setState(() {
        isTranslate = false;
      });
    }
    setState(() {
      textScanning = false;
    });
  }
}
