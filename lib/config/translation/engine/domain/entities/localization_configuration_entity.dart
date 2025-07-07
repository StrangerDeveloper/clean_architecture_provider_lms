import 'package:equatable/equatable.dart';

/// LocalizationConfigurationsEntity
class LocalizationConfigurationsEntity extends Equatable {
  final List<ConfigurationEntity>? configurations;
  final List<LanguageEntity>? languages;

  const LocalizationConfigurationsEntity({
    this.configurations,
    this.languages,
  });

  @override
  List<Object?> get props => [configurations, languages];

  @override
  bool? get stringify => true;
}

/// LanguageEntity
class LanguageEntity extends Equatable {
  final String? label;
  final String? value;
  final String? direction;

  const LanguageEntity({
    this.label,
    this.value,
    this.direction,
  });

  @override
  List<Object?> get props => [label, value, direction];

  @override
  bool? get stringify => true;
}

/// ConfigurationEntity
class ConfigurationEntity extends Equatable {
  final String? code;
  final Map<String, String>? configurations;

  const ConfigurationEntity({
    this.code,
    this.configurations,
  });

  @override
  List<Object?> get props => [code, configurations];

  @override
  bool? get stringify => true;
}
