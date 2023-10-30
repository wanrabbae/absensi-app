import 'package:app/global_resource.dart';

const InputDecorationTheme _kInputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorBluePrimary, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: Colors.redAccent, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorBluePrimary, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorBluePrimary, width: 2),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorGrayPrimary, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(color: colorGrayPrimary, width: 2),
  ),
);

class MainTheme {
  const MainTheme._();

  static GetMaterialApp materialApp(
    BuildContext context, {
    required Widget child,
  }) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: "Hora",
      getPages: Routes.pages,
      theme: _buildTheme(),
      darkTheme: _buildTheme(),
      home: SafeArea(
        bottom: false,
        top: false,
        child: child,
      ),
    );
  }

  static ThemeData _buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      inputDecorationTheme: _kInputDecorationTheme,
      fontFamily: kGlobalFontFamily,
    );
  }
}
