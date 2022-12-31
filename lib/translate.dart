import 'package:flutter/widgets.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:untitled/utils.dart';
List<TranslateLanguage> listLanguage = [
  TranslateLanguage.english,
  TranslateLanguage.vietnamese,
  TranslateLanguage.chinese,
  TranslateLanguage.spanish,
  TranslateLanguage.french,
  TranslateLanguage.arabic,
  TranslateLanguage.russian,
  TranslateLanguage.german,
  TranslateLanguage.italian,
];


class TranslateModel extends ChangeNotifier {
  String translateText = '';
  TranslateLanguage input1 = listLanguage[0];
  TranslateLanguage input2 = listLanguage[1];

  void setTranslateText(String text) {
    translateText = text;
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