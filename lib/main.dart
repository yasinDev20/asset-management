import 'package:computer_lab_inventory_application/config/routes/routes.dart';
import 'package:computer_lab_inventory_application/core/common/bloc/app_bloc_observer.dart';
import 'package:computer_lab_inventory_application/core/theme/theme.dart';
import 'package:computer_lab_inventory_application/core/common/injection/injection.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:computer_lab_inventory_application/features/user/presentation/bloc/user_bloc.dart';
import 'package:computer_lab_inventory_application/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

void main() async {
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
  }
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'id_ID';
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

    
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => myInjection<AuthBloc>()),
        BlocProvider(create: (context) => myInjection<UserBloc>()),
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
      ),
    );
  }
}
