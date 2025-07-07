import 'dart:ui' show Locale;

import '../../config/translation/engine/domain/entities/localization_configuration_entity.dart';

///
/// [OnLocalizationChanged] is a function that will be called whenever
/// localization is changed
///
typedef OnLocalizationChanged = Function(LanguageEntity?, Locale);