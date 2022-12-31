
import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:provider/provider.dart';
import 'package:untitled/image_translate.dart';
import 'package:untitled/translate.dart';
import 'package:untitled/utils.dart';

import 'image_scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TranslateModel>(context, listen: true);


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
                          model.getTranslate(text);
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
                              builder: (context) => ChangeNotifierProvider(create: (BuildContext context) {return ImageTranslateModel();  },
                              child: const ImageScanScreen())),
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
                  value: model.input1,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (TranslateLanguage? value) {
                    // This is called when the user selects an item.

                      model.setInput1(value!);
                      model.getTranslate(controller.value.text);

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
                      model.getTranslate(controller.value.text);
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
                child: Text(model.translateText == ""
                    ? "Translate goes here"
                    : model.translateText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
