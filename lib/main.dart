

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/theme.dart';
import 'package:shop_app/translation/codegen_loader.g.dart';

import 'layout/layout_screen.dart';
import 'moduls/login_screen/login_screen.dart';
import 'moduls/on_boarding/on_boarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'OnBoarding');
  token = CacheHelper.getData(key: 'token');
  print('token main =$token');

  late Widget widget;
  if (onBoarding != null) {
    if (token != null)
      widget = LayoutScreen();
    else
      widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translation',
        assetLoader: CodegenLoader(),
        // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        child: MyApp(
          onBoarding: onBoarding,
          startWidget: widget,
        ),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  final Widget startWidget;

  MyApp({required this.onBoarding, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..getHomeData()
              ..getFavourites()
              ..getProfile()
              ..getCategoriesData()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: startWidget,
      ),
    );
  }
}
