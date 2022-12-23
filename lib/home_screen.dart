import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:untitled/utils.dart';

import 'image_scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String translateText = '';
  TranslateLanguage input1 = listLanguage[0];
  TranslateLanguage input2 = listLanguage[1];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> getTranslate(String text) async {
      final result = await textTranslate(text, input1, input2);
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                        controller: controller,
                        onChanged: (text) {
                          getTranslate(text);
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Write something'),
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        maxLines: null),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ImageScanScreen()),
                        );
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                DropdownButton<TranslateLanguage>(
                  value: input1,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (TranslateLanguage? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      input1 = value!;
                      getTranslate(controller.value.text);
                    });
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
                  value: input2,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (TranslateLanguage? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      input2 = value!;
                      getTranslate(controller.value.text);
                    });
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
                height: 8,
              ),
              Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 180,
                ),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(8.0),
                child: Text(translateText == ""
                    ? "Translate goes here"
                    : translateText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
