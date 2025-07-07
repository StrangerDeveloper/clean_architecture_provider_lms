import 'package:equatable/equatable.dart';

class VerifyVersionEntity extends Equatable {
  final bool? status;

  const VerifyVersionEntity({this.status});

  @override
  List<Object?> get props => [status];

  @override
  bool? get stringify => true;
}
