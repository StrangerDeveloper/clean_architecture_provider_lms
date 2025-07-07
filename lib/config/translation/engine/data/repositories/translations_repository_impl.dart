import 'dart:convert' show jsonDecode;

import 'package:labor_management_system/config/translation/engine/data/models/localization_configuration_model.dart';
import 'package:labor_management_system/config/translation/engine/domain/entities/localization_configuration_entity.dart';
import 'package:labor_management_system/config/translation/engine/domain/repositories/translations_repository.dart';
import 'package:labor_management_system/core/services/firebase_services/remote_config_service.dart';

import '../../../../../core/type_defs/common_helper_types_type_defs.dart' show MapStringDynamic;

class TranslationsRepositoryImpl extends TranslationsRepository{
  final RemoteConfigService remoteConfigService;
   TranslationsRepositoryImpl({required this.remoteConfigService});

  @override
  Future<LocalizationConfigurationsEntity?> getTranslations() async {
    final jsonString =
    jsonDecode(remoteConfigService.getStringRemoteConfig("themes"))
    as MapStringDynamic;
    return LocalizationConfigurationsModel.fromJson(jsonString);
  }

}