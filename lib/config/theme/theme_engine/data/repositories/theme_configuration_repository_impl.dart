import 'dart:convert' show jsonDecode;

import 'package:labor_management_system/config/theme/theme_engine/data/models/theme_configuration_mdoel.dart';
import 'package:labor_management_system/config/theme/theme_engine/domain/entities/theme_configuration_entity.dart';
import 'package:labor_management_system/core/services/firebase_services/remote_config_service.dart';
import 'package:labor_management_system/core/type_defs/common_helper_types_type_defs.dart';

import '../../domain/repositories/theme_configuration_repository.dart';

class ThemeConfigurationRepositoryImpl extends ThemeConfigurationRepository {
  final RemoteConfigService remoteConfigService;

  ThemeConfigurationRepositoryImpl({required this.remoteConfigService});

  @override
  Future<ThemeConfigurationEntity> getFRCThemeConfiguration() async {
    final jsonString =
        jsonDecode(remoteConfigService.getStringRemoteConfig("themes"))
            as MapStringDynamic;
    return ThemeConfigurationModel.fromJson(jsonString['data']);
  }
}
