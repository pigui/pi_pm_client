import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:pi_pm_client/core/services/injection_container.dart';
import 'package:pi_pm_client/core/services/router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:toastification/toastification.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final delegate = await LocalizationDelegate.create(
      fallbackLocale: 'es', supportedLocales: ['es']);
  await init();
  runApp(LocalizedApp(delegate, const MyApp()));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
        state: LocalizationProvider.of(context).state,
        child: ToastificationWrapper(
            child: GlobalLoaderOverlay(
                overlayWidgetBuilder: (_) {
                  return const Center(
                    child: SpinKitCubeGrid(
                      color: Colors.white,
                      size: 50.0,
                    ),
                  );
                },
                child: MaterialApp.router(
                  routerConfig: router,
                  debugShowCheckedModeBanner: false,
                  themeMode: ThemeMode.system,
                  theme: ThemeData.light(useMaterial3: true).copyWith(),
                  darkTheme: ThemeData.dark(useMaterial3: true).copyWith(),
                  builder: (context, child) => ResponsiveBreakpoints.builder(
                      child: child!,
                      breakpoints: [
                        const Breakpoint(start: 0, end: 450, name: MOBILE),
                        const Breakpoint(start: 451, end: 800, name: TABLET),
                        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                        const Breakpoint(
                            start: 1921, end: double.infinity, name: '4K')
                      ]),
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    localizationDelegate
                  ],
                  supportedLocales: localizationDelegate.supportedLocales,
                  locale: localizationDelegate.currentLocale,
                ))));
  }
}
