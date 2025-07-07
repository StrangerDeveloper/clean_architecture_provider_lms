import 'package:equatable/equatable.dart';

class DarkThemeIconPackEntity extends Equatable {
  const DarkThemeIconPackEntity({
    this.appErrorAlertIcon,
    this.contractIcon,
    this.profileIcon,
    this.refreshIcon,
    this.registerIcon,
    this.settingsIcon,
    this.signOutIcon,
    this.workerIcon,
  });

  final String? appErrorAlertIcon,
      profileIcon,
      settingsIcon,
      signOutIcon,
      registerIcon,
      contractIcon,
      workerIcon,
      refreshIcon;

  DarkThemeIconPackEntity copyWith({
    String? appErrorAlertIcon,
    String? profileIcon,
    String? settingsIcon,
    String? signOutIcon,
    String? registerIcon,
    String? contractIcon,
    String? workerIcon,
    String? refreshIcon,
  }) {
    return DarkThemeIconPackEntity(
      appErrorAlertIcon: appErrorAlertIcon ?? this.appErrorAlertIcon,
      profileIcon: profileIcon ?? this.profileIcon,
      settingsIcon: settingsIcon ?? this.settingsIcon,
      signOutIcon: signOutIcon ?? this.signOutIcon,
      registerIcon: registerIcon ?? this.registerIcon,
      contractIcon: contractIcon ?? this.contractIcon,
      workerIcon: workerIcon ?? this.workerIcon,
      refreshIcon: refreshIcon ?? refreshIcon,
    );
  }

  @override
  List<Object?> get props => [
    appErrorAlertIcon,
    profileIcon,
    settingsIcon,
    signOutIcon,
    registerIcon,
    contractIcon,
    workerIcon,
    refreshIcon,
  ];

  @override
  bool? get stringify => true;
}
