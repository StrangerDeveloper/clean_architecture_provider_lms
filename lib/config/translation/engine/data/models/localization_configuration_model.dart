import 'package:labor_management_system/config/translation/engine/domain/entities/localization_configuration_entity.dart';
import 'package:labor_management_system/core/data/data_source/generics/decoder/decoder.dart';
import 'package:labor_management_system/core/type_defs/common_helper_types_type_defs.dart';

class LocalizationConfigurationsModel extends LocalizationConfigurationsEntity
    implements Decodable {
  const LocalizationConfigurationsModel({
    super.configurations,
    super.languages,
  });

  factory LocalizationConfigurationsModel.fromJson(MapStringDynamic? json) {
    return LocalizationConfigurationsModel(
      configurations: json?["configurations"] == null
          ? []
          : List<ConfigurationModel>.from(
              json?["configurations"].map(
                (x) => ConfigurationModel.fromJson(x),
              ),
            ),
      languages: json?["languages"] == null
          ? []
          : List<LanguageModel>.from(
              json?["languages"].map((x) => LanguageModel.fromJson(x)),
            ),
    );
  }

  @override
  LocalizationConfigurationsModel decode(dynamic json) {
    return LocalizationConfigurationsModel.fromJson(json);
  }
}

class LanguageModel extends LanguageEntity implements Decodable {
  const LanguageModel({super.direction, super.label, super.value});

  factory LanguageModel.fromJson(MapStringDynamic? json) {
    return LanguageModel(
      direction: json?["direction"] ?? "",
      label: json?["label"] ?? "",
      value: json?["value"] ?? "",
    );
  }

  @override
  LanguageModel decode(dynamic json) {
    return LanguageModel.fromJson(json);
  }

  MapStringDynamic? toJson() {
    return {
      "label": label,
      "value": value,
      "direction": direction,
    };
  }
}

class ConfigurationModel extends ConfigurationEntity implements Decodable {
  const ConfigurationModel({super.code, super.configurations});

  factory ConfigurationModel.fromJson(MapStringDynamic? json) {
    return ConfigurationModel(
      code: json?['code'] ?? "",
      configurations: MapStringString.from(json?["configurations"] ?? ""),
    );
  }

  @override
  ConfigurationModel decode(dynamic json) {
    return ConfigurationModel.fromJson(json);
  }
}
