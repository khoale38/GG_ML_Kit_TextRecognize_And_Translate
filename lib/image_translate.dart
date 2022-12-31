import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/translate.dart';
import 'package:untitled/utils.dart';

class ImageTranslateModel extends ChangeNotifier {
  bool textScanning = false;

  XFile? imageFile;

  String scannedText = "";

  String translateText = "";

  bool isTranslate = false;

  TranslateLanguage input1 = listLanguage[0];
  TranslateLanguage input2 = listLanguage[1];

  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  void setTranslateText(String text) {
    translateText = text;
    notifyListeners();
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        getText(imageFile!).then((value) => null);
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      scannedText = "Error occured while scanning";
    }
    notifyListeners();
  }

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

          scannedText = "$scannedText${element.text} ";
        }
      }
    }

    if (text == "") {
      scannedText = "No Text Founds";
      translateText = "Khong co van ban duoc tim thay";
    } else {
      isTranslate = true;

      translateText = await textTranslate(scannedText, input1, input2);

      isTranslate = false;
    }

    textScanning = false;
    notifyListeners();
  }

  void setInput1(TranslateLanguage language) {
    input1 = language;
    notifyListeners();
  }

  void setInput2(TranslateLanguage language) {
    input2 = language;
    notifyListeners();
  }

  Future<void> getTranslate(String text) async {
    final result = await textTranslate(text, input1, input2);
    setTranslateText(result);
  }


}
