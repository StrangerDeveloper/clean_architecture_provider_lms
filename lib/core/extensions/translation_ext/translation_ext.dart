import '../../utils/injector_utils/injector_helper.dart';

/// Create extension to handle translation engine on key
extension TranslationExt on String {
  String get translate => injectedTranslationEngine.getTranslation(this);

  ///helps to get translation if both translations required in cases
  String getTranslationViaLangKey({required String langKey}) =>
      injectedTranslationEngine.getTranslation(this, langKey);
}
