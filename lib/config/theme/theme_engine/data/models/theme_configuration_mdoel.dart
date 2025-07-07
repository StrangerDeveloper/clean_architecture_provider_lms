import 'package:labor_management_system/config/theme/theme_engine/domain/entities/theme_configuration_entity.dart';
import 'package:labor_management_system/core/type_defs/common_helper_types_type_defs.dart';

class ThemeConfigurationModel extends ThemeConfigurationEntity {
  const ThemeConfigurationModel({super.dark, super.light});

  factory ThemeConfigurationModel.fromJson(MapStringDynamic json) {
    return ThemeConfigurationModel(
      dark: json["dark"] == null ? null : ThemeModel.fromJson(json["dark"]),
      light: json["light"] == null ? null : ThemeModel.fromJson(json["light"]),
    );
  }
}

class ThemeModel extends ThemeEntity {
  const ThemeModel({
    required super.name,
    required super.prefix,
    required super.font,
    required super.colors,
  });

  factory ThemeModel.fromJson(MapStringDynamic json) => ThemeModel(
    name: json["name"] ?? '',
    prefix: json["prefix"] ?? '',
    font: json["font"] ?? '',
    colors: json["colors"] == null
        ? {}
        : Map<String, String>.from(json["colors"]),
  );
}
