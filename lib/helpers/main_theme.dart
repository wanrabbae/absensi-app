import 'package:app/global_resource.dart';

TextStyle rubikTextStyle = TextStyle(fontFamily: 'Rubik');

class MainTheme {
  const MainTheme._();

  static GetMaterialApp materialApp(BuildContext context,
      {required Widget child}) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      title: "Hora",
      getPages: Routes.pages,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorBluePrimary, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.redAccent, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorBluePrimary, width: 2)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorBluePrimary, width: 2)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorGrayPrimary, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorGrayPrimary, width: 2))),
          fontFamily: "Rubik",
          textTheme: TextTheme(
            bodyText1: rubikTextStyle,
            bodyText2: rubikTextStyle,
            // bodyLarge: rubikTextStyle,
            // // bodyMedium: rubikTextStyle,
            // // bodySmall: rubikTextStyle,
          )),
      darkTheme: ThemeData(
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorBluePrimary, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.redAccent, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorBluePrimary, width: 2)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorBluePrimary, width: 2)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorGrayPrimary, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: colorGrayPrimary, width: 2))),
          colorScheme: lightColorScheme,
          fontFamily: "Rubik",
          textTheme: GoogleFonts.rubikTextTheme()),
      home: SafeArea(
        bottom: false,
        top: false,
        child: child,
      ),
    );
  }

  static TextStyle textStylePrimary(
      {double customFontSize = 14,
      FontWeight customFontWeight = FontWeight.bold,
      Color customColor = colorBluePrimary}) {
    return TextStyle(
        fontWeight: customFontWeight,
        fontSize: customFontSize,
        fontFamily: 'Rubik',
        color: customColor);
  }
}
