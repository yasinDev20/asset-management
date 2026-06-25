import 'package:assetmanagement/config/routes/routes.dart';
import 'package:assetmanagement/core/common/bloc/app_bloc_observer.dart';
import 'package:assetmanagement/core/theme/theme.dart';
import 'package:assetmanagement/core/common/injection/injection.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';

import 'package:web/web.dart' as web;

void main() async {
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await injectionInit();
  Intl.defaultLocale = 'id_ID';

  if (!kIsWeb) {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  await Hive.openBox('recentCategorySelections');
  await Hive.openBox('recentBrandSelections');
  await Hive.openBox('recentLocationSelections');

  await Supabase.initialize(
    url: 'https://uzzuacawolizquuqylev.supabase.co',
    anonKey: 'sb_publishable_D5bcN2CFRoD9ihmEGwACsg_2Es-7dSz',
  );
  await myInjection<GoogleSignIn>().initialize(
    //web client id
    serverClientId: kIsWeb
        ? null
        : '1060762376589-ijpes02hb25vnue9s99j2ev3p9o4s68k.apps.googleusercontent.com',
  );

  // Hapus query code dari google sign in redirect URL tanpa reload
  if (kIsWeb) {
    web.window.history.replaceState(null, '', '/');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(Typography.material2021().black);
    //Global Bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => myInjection<AuthBloc>()),
        BlocProvider(create: (context) => myInjection<UserBloc>()),
        BlocProvider(create: (context) => myInjection<AssetBloc>()),
      ],

      child: MaterialApp.router(
        routerConfig: MyRouter.router,
        debugShowCheckedModeBanner: false,
        theme: materialTheme.light(),

        supportedLocales: [Locale('id')],
        localizationsDelegates: [
          ...GlobalMaterialLocalizations.delegates,
          FormBuilderLocalizations.delegate,
        ],
        builder: (context, child) {
          return child!;
        },
      ),
    );
  }
}
