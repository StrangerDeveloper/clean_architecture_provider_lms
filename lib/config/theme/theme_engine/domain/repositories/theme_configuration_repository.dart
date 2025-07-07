import 'package:labor_management_system/config/theme/theme_engine/domain/entities/theme_configuration_entity.dart';

abstract class ThemeConfigurationRepository{

  //method used for to fetch Firebase Remote Config (FRC) Theme configuration in json form.
  Future<ThemeConfigurationEntity?> getFRCThemeConfiguration();
}