import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labor_management_system/core/extensions/theme_color/theme_color_ext.dart';
import 'package:labor_management_system/core/shared/widgets/custom_asset_image/custom_asset_image.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';
import 'package:labor_management_system/features/dashboard/presentation/view_models/dashboard_view_model.dart';
import 'package:labor_management_system/features/splash/presentation/view_models/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  ///
  /// Route name
  ///
  static const String id = "/";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<DashboardViewModel, SplashViewModel>(
      create: (context) => SplashViewModel(
        dashboardViewModel: Provider.of<DashboardViewModel>(
          context,
          listen: false,
        ),
      ),
      update: (context, dashboardViewModel, previousSplashViewModel) =>
          previousSplashViewModel ??
          SplashViewModel(dashboardViewModel: dashboardViewModel),

      child: Consumer<SplashViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor:
                injectedAppColorKeys.scaffoldBackgroundColor.themeColor,
            body: Center(
              child: CustomAssetImage(
                semanticValue: injectedAppSemantics.appLogoImage,
                //TODO: change the image with actual logo...
                imagePath: injectedAppIcons.appErrorAlertDark,
                width: 1.0.sw * 0.65,
              ),
            ),
          );
        },
      ),
    );
  }
}
