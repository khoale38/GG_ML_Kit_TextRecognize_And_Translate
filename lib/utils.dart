import 'package:google_mlkit_translation/google_mlkit_translation.dart';

Future<String> textTranslate(String text) async {
  final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.english,
      targetLanguage: TranslateLanguage.vietnamese);
  final String response = await onDeviceTranslator.translateText(text);

  return response;
}
