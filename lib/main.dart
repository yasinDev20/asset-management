import 'package:assetmanagement/config/routes/routes.dart';
import 'package:assetmanagement/core/common/bloc/app_bloc_observer.dart';
import 'package:assetmanagement/core/theme/theme.dart';
import 'package:assetmanagement/core/common/injection/injection.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_list_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_support_bloc.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/user/presentation/bloc/user_bloc.dart';
import 'package:assetmanagement/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
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

void main() async {
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  await Hive.openBox('recentCategorySelections');
  await Hive.openBox('recentBrandSelections');
  await Hive.openBox('recentLocationSelections');

  Intl.defaultLocale = 'id_ID';
  await Supabase.initialize(
    url: 'https://uzzuacawolizquuqylev.supabase.co',
    anonKey: 'sb_publishable_D5bcN2CFRoD9ihmEGwACsg_2Es-7dSz',
  );
  await injectionInit();
  await GoogleSignIn.instance.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialTheme = MaterialTheme(Typography.material2021().black);
    //TODO: pindahkan yang tidak global
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => myInjection<AuthBloc>()),
        BlocProvider(create: (context) => myInjection<UserBloc>()),
        BlocProvider(create: (context) => myInjection<AssetBloc>()),
        BlocProvider(create: (context) => myInjection<AssetSupportBloc>()),
        BlocProvider(create: (context) => myInjection<AssetListBloc>()),
      ],

      child: MaterialApp.router(
        routerConfig: MyRouter().router,
        debugShowCheckedModeBanner: false,
        theme: materialTheme.light(),

        supportedLocales: [Locale('id')],
        localizationsDelegates: [
          ...GlobalMaterialLocalizations.delegates,
          FormBuilderLocalizations.delegate,
        ],
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AssetBloc, AssetState>(
                listenWhen: (previous, current) => current is AssetFailureState,
                listener: (context, state) {
                  if (state is AssetFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ],
            child: child!,
          );
        },
      ),
    );
  }
}
