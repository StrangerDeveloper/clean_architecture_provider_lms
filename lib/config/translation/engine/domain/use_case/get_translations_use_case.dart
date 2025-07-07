import 'package:labor_management_system/config/translation/engine/domain/entities/localization_configuration_entity.dart';
import 'package:labor_management_system/config/translation/engine/domain/repositories/translations_repository.dart';
import 'package:labor_management_system/core/use_cases/use_case.dart';

class GetTranslationsUseCase implements UseCase<LocalizationConfigurationsEntity?, void>{
  final TranslationsRepository translationsRepository;

  GetTranslationsUseCase({required this.translationsRepository});


  @override
  Future<LocalizationConfigurationsEntity?> call({void params}) {
    return translationsRepository.getTranslations();
  }

}