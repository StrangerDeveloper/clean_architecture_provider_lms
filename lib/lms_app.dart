import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labor_management_system/config/theme/theme_engine/presentation/view_models/theme_view_model.dart';
import 'package:labor_management_system/config/translation/engine/presentation/view_models/translation_view_model.dart';
import 'package:labor_management_system/core/utils/global_utils/global_utils.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';
import 'package:provider/provider.dart';

import 'config/router/app_router.dart';
import 'core/injectors/injector.dart';
import 'core/shared/widgets/custom_base_change_notifier_widgets/base_change_notifier_provider.dart';

class LmsApp extends StatelessWidget {
  const LmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: injectedAppProviders.providers,
      child: BaseChangeNotifierProvider<ThemeViewModel>(
        create: (context) => ThemeViewModel(),
        builder: (context, themeViewModel) =>
            BaseChangeNotifierProvider<TranslationViewModel>(
              create: (_) => TranslationViewModel(),
              builder: (context, translationViewModel) =>
                  ValueListenableBuilder<Locale>(
                    valueListenable: translationViewModel.localeNotifier,
                    builder: (context, locale, child) => ScreenUtilInit(
                      minTextAdapt: true,
                      builder: (context, child) => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        themeMode: themeViewModel.activeTheme,
                        theme: themeViewModel.lightTheme,
                        darkTheme: themeViewModel.darkTheme,
                        navigatorKey: navigatorKey,
                        locale: locale,
                        localizationsDelegates: translationViewModel.localizationsDelegates,
                        supportedLocales: translationViewModel.supportedLocales,
                        onGenerateRoute: injector<AppRouter>().onGenerateRoute,
                      ),
                    ),
                  ),
            ),
      ),
    );
  }
}
