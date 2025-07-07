import 'package:labor_management_system/config/theme/theme_engine/presentation/view_models/theme_view_model.dart';
import 'package:labor_management_system/features/dashboard/presentation/view_models/dashboard_view_model.dart';
import 'package:provider/provider.dart';

import '../translation/engine/presentation/view_models/translation_view_model.dart';

class AppProviders{

final List<InheritedProvider<dynamic>> providers = [

  //ChangeNotifierProvider(create: create);
  ChangeNotifierProvider<ThemeViewModel>(create: (context) => ThemeViewModel()),
  ChangeNotifierProvider<TranslationViewModel>(create: (context) => TranslationViewModel()),
  ChangeNotifierProvider<DashboardViewModel>(create: (context)=> DashboardViewModel()),
];

}