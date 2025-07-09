import 'package:flutter/material.dart';
    import 'package:fresha/homePage.dart';
    import 'package:get/get.dart';
    import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

    void main() {
      runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
      const MyApp({super.key});

      @override
      Widget build(BuildContext context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          onGenerateRoute: (settings) {
            return MaterialWithModalsPageRoute(
              settings: settings,
              builder: (context) => const HomePage(),
            );
          },
          // The home property is now handled by onGenerateRoute
          // home: const HomePage(),
        );
      }
    }