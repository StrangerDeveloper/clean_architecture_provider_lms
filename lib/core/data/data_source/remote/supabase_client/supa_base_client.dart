import 'package:labor_management_system/core/extensions/logs/log_ext.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupaBaseClient {
  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  /// supabase client instance
  late final SupabaseClient supabase;

  /// The flag variable to handle one time initialization
  bool _isInitialized = false;

  /* -------------------------------------------------------------------------- */
  /*                                  GETTERS                                   */
  /* -------------------------------------------------------------------------- */

  bool get isInitialized => _isInitialized;

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  /// init the method used for to initialized supa base client and connect to db
  Future<void> initSupaBase() async {
    if (_isInitialized) return;
    try {
      await Supabase.initialize(
        url: injectedApiConstant.baseUrl,
        anonKey: injectedApiConstant.publicANONKey,
      );

      supabase = Supabase.instance.client;
      _isInitialized = true;
    } catch (e) {
      "Error: Supabase:: $e".logError();
      _isInitialized = false;
    }
  }



}
