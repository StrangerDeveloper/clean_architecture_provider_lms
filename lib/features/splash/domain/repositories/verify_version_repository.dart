import 'package:labor_management_system/features/splash/domain/entities/verify_version_entity.dart';

abstract class VerifyVersionRepository {
  Future<VerifyVersionEntity?> getVerifyVersion({required String? appVersion});
}
