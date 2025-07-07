
import 'package:labor_management_system/core/extensions/logs/log_ext.dart';
import 'package:labor_management_system/features/splash/domain/entities/verify_version_entity.dart';
import 'package:labor_management_system/features/splash/domain/repositories/verify_version_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerifyVersionRepositoryImpl implements VerifyVersionRepository {
  final SupabaseClient supaBaseClient;

  VerifyVersionRepositoryImpl({required this.supaBaseClient});

  @override
  Future<VerifyVersionEntity?> getVerifyVersion({
    required String? appVersion,
  }) async {
    try {
      final response = await supaBaseClient
          .from('app_versions')
          .select('versions')
          .order('creation_date', ascending: false)
          .limit(1)
          .single();

      final versions = List<String>.from(response['versions'] ?? []);

      final status = versions.contains(appVersion);
      return VerifyVersionEntity(status: status);
    } catch (e) {
      e.toString().logError();
      return VerifyVersionEntity(status: false);
    }
  }
}
