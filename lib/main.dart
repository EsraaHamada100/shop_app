import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/register/cubit/register_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/shared/cubit/app_statues.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'shared/components/constants.dart';
import 'shared/cubit/app_cubit.dart';

void main() async {
  // I use this because I used async
  WidgetsFlutterBinding.ensureInitialized();
  // DioHelper.init();

  print('we are in main');
  await CacheHelper.init();
  await DioHelper.init();

  bool isDark = CacheHelper.getData(key: "isDark") ?? false;
  // this line should be removed after setting the dark mode logic
  bool onBoarding = CacheHelper.getData(key: "onBoarding") ?? false;
  String? token = CacheHelper.getData(key: 'token');

  Widget widget;
  if (token != null) {
    print('the token is $token');
    myToken = token;
    widget = const ShopLayout();
  } else if (onBoarding) {
    widget = LoginScreen();
  } else {
    widget = OnBoardingScreen();
  }
  runApp(MyApp(
    isDark: isDark,
    onBoarding: onBoarding,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final bool onBoarding;
  final Widget startWidget;
  const MyApp({
    required this.isDark,
    required this.onBoarding,
    required this.startWidget,
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // bool isDark = CacheHelper.getData(key: 'isDark')!;
    // I create all of my BlocProviders here to use them throughout the app
    // if you had only one you can do that
    // BlocProvider(create: (BuildContext context) => AppCubit(), child:BlocConsumer())
    // ut here we have multiple of them so we have to use this method
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        // BlocProvider(
        //  // ..getThing() by this way I call the function on cubit to be executed
        //  // once I open this page
        //   create: (BuildContext context) => NewsCubit()
        //     ..getBusiness()
        //     ..getSports()
        //     ..getScience(),
        // ),
        // BlocProvider(
        //   create: (BuildContext context) => AppCubit()..changeAppMode(),
        // ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
          ..getUserData(),
        ),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context)=>SearchCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStatues>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: (isDark) ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
