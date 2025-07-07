import 'package:labor_management_system/config/translation/engine/domain/entities/localization_configuration_entity.dart';

abstract class TranslationsRepository{
  Future<LocalizationConfigurationsEntity?> getTranslations();
}