import 'package:labor_management_system/core/use_cases/use_case.dart';
import 'package:labor_management_system/features/splash/domain/entities/verify_version_entity.dart';
import 'package:labor_management_system/features/splash/domain/repositories/verify_version_repository.dart';

class VerifyVersionUseCase implements UseCase<VerifyVersionEntity?, String?>{

  final VerifyVersionRepository verifyVersionRepository;
  VerifyVersionUseCase({required this.verifyVersionRepository});

  @override
  Future<VerifyVersionEntity?> call({String? params}) {

    return verifyVersionRepository.getVerifyVersion(appVersion: params);
  }



}