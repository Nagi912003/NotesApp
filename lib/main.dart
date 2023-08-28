import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'package:untitled1/providers/notes.dart';

import 'screens/home_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // var box =
  await Hive.openBox('navigation');
  // box.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Notes notes = Notes();
    notes.fetchNotes();
    return ChangeNotifierProvider(
      create: (context) => notes,
      child: ScreenUtilInit(
        designSize: const Size(411.42857142857144, 914.2857142857143),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              textTheme: TextTheme(
                titleSmall: GoogleFonts.montserrat(),
                titleMedium: GoogleFonts.montserrat(),
                titleLarge: GoogleFonts.montserrat(),
                displaySmall: GoogleFonts.montserrat(),
                displayMedium: GoogleFonts.montserrat(),
                displayLarge: GoogleFonts.montserrat(),
                bodySmall: GoogleFonts.montserrat(),
                bodyMedium: GoogleFonts.montserrat(),
                bodyLarge: GoogleFonts.montserrat(),
              ),
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}

