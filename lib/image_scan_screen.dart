import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled/translate.dart';

import 'image_translate.dart';

class ImageScanScreen extends StatefulWidget {
  const ImageScanScreen({Key? key}) : super(key: key);

  @override
  State<ImageScanScreen> createState() => _ImageScanScreenState();
}

class _ImageScanScreenState extends State<ImageScanScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ImageTranslateModel>(context, listen: true);

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
                if (!model.textScanning && model.imageFile == null)
                  Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300]!,
                  ),
                if (model.imageFile != null)
                  Image.file(File(model.imageFile!.path)),
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
                            model.getImage(ImageSource.gallery);
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
                            model.getImage(ImageSource.camera);
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
                model.textScanning
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
                          model.scannedText,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  DropdownButton<TranslateLanguage>(
                    value: model.input1,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (TranslateLanguage? value) {
                      model.setInput1(value!);
                      model.getTranslate(model.scannedText);

                    },
                    items: listLanguage.map<DropdownMenuItem<TranslateLanguage>>(
                            (TranslateLanguage value) {
                          return DropdownMenuItem<TranslateLanguage>(
                            value: value,
                            child: Text(value.name.toString()),
                          );
                        }).toList(),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text('To'),
                  const SizedBox(
                    width: 15,
                  ),
                  DropdownButton<TranslateLanguage>(
                    value: model.input2,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (TranslateLanguage? value) {
                      // This is called when the user selects an item.
                      model.setInput2(value!);
                      model.getTranslate(model.scannedText);
                    },
                    items: listLanguage.map<DropdownMenuItem<TranslateLanguage>>(
                            (TranslateLanguage value) {
                          return DropdownMenuItem<TranslateLanguage>(
                            value: value,
                            child: Text(value.name.toString()),
                          );
                        }).toList(),
                  )
                ]),
                const SizedBox(
                  height: 10,
                ),
                model.isTranslate
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
                          model.translateText == "" ? "" : model.translateText,
                          style: const TextStyle(fontSize: 20),
                        ),
                      )
              ],
            )),
      ),
    );
  }
}
