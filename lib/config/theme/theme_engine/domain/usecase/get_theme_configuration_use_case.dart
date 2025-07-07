import 'package:labor_management_system/config/theme/theme_engine/domain/entities/theme_configuration_entity.dart';
import 'package:labor_management_system/config/theme/theme_engine/domain/repositories/theme_configuration_repository.dart';
import 'package:labor_management_system/core/use_cases/use_case.dart';

class GetThemeConfigurationUseCase
    implements UseCase<ThemeConfigurationEntity?, void> {
  ThemeConfigurationRepository themeRepo;

  GetThemeConfigurationUseCase({required this.themeRepo});

  @override
  Future<ThemeConfigurationEntity?> call({void params}) async =>
      await themeRepo.getFRCThemeConfiguration();
}
