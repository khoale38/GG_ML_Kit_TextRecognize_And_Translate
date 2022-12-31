import 'package:google_mlkit_translation/google_mlkit_translation.dart';

Future<String> textTranslate(
    String text, TranslateLanguage input1, TranslateLanguage input2) async {
  final onDeviceTranslator =
      OnDeviceTranslator(sourceLanguage: input1, targetLanguage: input2);
  final String response = await onDeviceTranslator.translateText(text);

  return response;
}

