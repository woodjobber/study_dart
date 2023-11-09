import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/log.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/get_navigation.dart';

class GetXCupertinoApp extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;

  final Widget? home;

  /// Lazy function
  final Map<String, WidgetBuilder>? Function()? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final CustomTransition? customTransition;
  final Color? color;
  final Map<String, Map<String, String>>? translationsKeys;
  final Translations? translations;
  final TextDirection? textDirection;
  final Locale? locale;
  final Locale? fallbackLocale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final Map<LogicalKeySet, Intent>? shortcuts;
  final ThemeData? highContrastTheme;
  final ThemeData? highContrastDarkTheme;
  final Map<Type, Action<Intent>>? actions;
  final Function(Routing?)? routingCallback;
  final Transition? defaultTransition;
  final bool? opaqueRoute;
  final VoidCallback? onInit;
  final VoidCallback? onReady;
  final VoidCallback? onDispose;
  final bool? enableLog;
  final LogWriterCallback? logWriterCallback;
  final bool? popGesture;
  final SmartManagement smartManagement;
  final Bindings? initialBinding;
  final Duration? transitionDuration;
  final bool? defaultGlobalState;

  /// Lazy function
  final List<GetPage>? Function()? getPages;

  final GetPage? unknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  late final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;
  final CupertinoThemeData? theme;
  final bool useInheritedMediaQuery;

  /// Side effect. Others that need to be initialized in advance.
  final Function()? effect;

  late final Bindings? _initialBinding;
  late final Map<String, Widget Function(BuildContext)> _routes;
  late final List<GetPage>? _getPages;
  // ignore: unused_field
  late final Function()? _effect;

  GetXCupertinoApp({
    Key? key,
    this.effect,
    this.navigatorKey,
    this.home,
    Map<String, Widget Function(BuildContext)> Function()? this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.useInheritedMediaQuery = false,
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.builder,
    this.textDirection,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.theme,
    this.locale,
    this.fallbackLocale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.routingCallback,
    this.defaultTransition,
    this.getPages,
    this.opaqueRoute,
    this.enableLog = kDebugMode,
    this.logWriterCallback,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.unknownRoute,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.actions,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        super(key: key) {
    _effect = effect?.call();
    _initialBinding = initialBinding?..dependencies();
    _getPages = getPages?.call();
    _routes = routes?.call() ?? const <String, WidgetBuilder>{};
  }

  GetXCupertinoApp.router({
    Key? key,
    this.theme,
    this.routeInformationProvider,
    RouteInformationParser<Object>? routeInformationParser,
    RouterDelegate<Object>? routerDelegate,
    this.backButtonDispatcher,
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.useInheritedMediaQuery = false,
    this.color,
    this.highContrastTheme,
    this.highContrastDarkTheme,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.shortcuts,
    this.actions,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.textDirection,
    this.fallbackLocale,
    this.routingCallback,
    this.defaultTransition,
    this.opaqueRoute,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.enableLog = kDebugMode,
    this.logWriterCallback,
    this.popGesture,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.transitionDuration,
    this.defaultGlobalState,
    this.getPages,
    this.unknownRoute,
    this.effect,
  })  : routerDelegate = routerDelegate ??= Get.createDelegate(
          notFoundRoute: unknownRoute,
        ),
        navigatorObservers = null,
        navigatorKey = null,
        onGenerateRoute = null,
        home = null,
        onGenerateInitialRoutes = null,
        onUnknownRoute = null,
        routes = null,
        initialRoute = null,
        super(key: key) {
    _effect = effect?.call();
    _initialBinding = initialBinding?..dependencies();
    _getPages = getPages?.call();

    _routes = routes?.call() ?? const <String, WidgetBuilder>{};

    this.routeInformationParser =
        routeInformationParser ??= Get.createInformationParser(
      initialRoute: _getPages?.first.name ?? '/',
    );

    Get.routerDelegate = routerDelegate;
    Get.routeInformationParser = routeInformationParser;
  }

  @override
  Widget build(BuildContext context) {
    if (routerDelegate != null) {
      return GetCupertinoApp.router(
        key: key,
        routerDelegate: routerDelegate,
        routeInformationParser: routeInformationParser,
        routeInformationProvider: routeInformationProvider,
        backButtonDispatcher: backButtonDispatcher,
        initialBinding: _initialBinding,
        getPages: _getPages,
        useInheritedMediaQuery: useInheritedMediaQuery,
        builder: builder,
        textDirection: textDirection,
        title: title,
        onGenerateTitle: onGenerateTitle,
        color: color,
        theme: theme,
        locale: locale,
        fallbackLocale: fallbackLocale,
        localizationsDelegates: localizationsDelegates,
        localeListResolutionCallback: localeListResolutionCallback,
        localeResolutionCallback: localeResolutionCallback,
        supportedLocales: supportedLocales,
        showPerformanceOverlay: showPerformanceOverlay,
        checkerboardRasterCacheImages: checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: checkerboardOffscreenLayers,
        showSemanticsDebugger: showSemanticsDebugger,
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        shortcuts: shortcuts,
        customTransition: customTransition,
        translationsKeys: translationsKeys,
        translations: translations,
        onInit: onInit,
        onReady: onReady,
        onDispose: onDispose,
        routingCallback: routingCallback,
        defaultTransition: defaultTransition,
        opaqueRoute: opaqueRoute,
        enableLog: enableLog,
        logWriterCallback: logWriterCallback,
        popGesture: popGesture,
        transitionDuration: transitionDuration,
        defaultGlobalState: defaultGlobalState,
        smartManagement: smartManagement,
        unknownRoute: unknownRoute,
        highContrastTheme: highContrastTheme,
        highContrastDarkTheme: highContrastDarkTheme,
        actions: actions,
      );
    }
    return GetCupertinoApp(
      key: key,
      navigatorKey: navigatorKey,
      initialBinding: _initialBinding,
      getPages: _getPages,
      routes: _routes,
      home: home,
      initialRoute: initialRoute,
      onGenerateRoute: onGenerateRoute,
      onGenerateInitialRoutes: onGenerateInitialRoutes,
      onUnknownRoute: onUnknownRoute,
      useInheritedMediaQuery: useInheritedMediaQuery,
      navigatorObservers: navigatorObservers ?? const <NavigatorObserver>[],
      builder: builder,
      textDirection: textDirection,
      title: title,
      onGenerateTitle: onGenerateTitle,
      color: color,
      theme: theme,
      locale: locale,
      fallbackLocale: fallbackLocale,
      localizationsDelegates: localizationsDelegates,
      localeListResolutionCallback: localeListResolutionCallback,
      localeResolutionCallback: localeResolutionCallback,
      supportedLocales: supportedLocales,
      showPerformanceOverlay: showPerformanceOverlay,
      checkerboardRasterCacheImages: checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: checkerboardOffscreenLayers,
      showSemanticsDebugger: showSemanticsDebugger,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      shortcuts: shortcuts,
      customTransition: customTransition,
      translationsKeys: translationsKeys,
      translations: translations,
      onInit: onInit,
      onReady: onReady,
      onDispose: onDispose,
      routingCallback: routingCallback,
      defaultTransition: defaultTransition,
      opaqueRoute: opaqueRoute,
      enableLog: enableLog,
      logWriterCallback: logWriterCallback,
      popGesture: popGesture,
      transitionDuration: transitionDuration,
      defaultGlobalState: defaultGlobalState,
      smartManagement: smartManagement,
      unknownRoute: unknownRoute,
      highContrastTheme: highContrastTheme,
      highContrastDarkTheme: highContrastDarkTheme,
      actions: actions,
    );
  }
}
