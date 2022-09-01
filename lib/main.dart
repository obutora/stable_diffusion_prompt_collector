import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/component/screen/home_screen.dart';
import 'package:stable_diffusion_prompt_collector/component/theme/colors.dart';
import 'package:stable_diffusion_prompt_collector/entity/objectBox/promptBox.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PromptBox.create();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stable Diffusion Prompt Collector',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: GoogleFonts.notoSansJavanese(
                fontSize: 93,
                fontWeight: FontWeight.w300,
                letterSpacing: -1.5,
                color: white200),
            headline2: GoogleFonts.notoSansJavanese(
                fontSize: 58,
                fontWeight: FontWeight.w300,
                letterSpacing: -0.5,
                color: white200),
            headline3: GoogleFonts.notoSansJavanese(
                fontSize: 47, fontWeight: FontWeight.w400, color: white200),
            headline4: GoogleFonts.notoSansJavanese(
                fontSize: 33,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.25,
                color: white200),
            headline5: GoogleFonts.notoSansJavanese(
                fontSize: 23, fontWeight: FontWeight.w400, color: white200),
            headline6: GoogleFonts.notoSansJavanese(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15,
                color: white200),
            subtitle1: GoogleFonts.notoSansJavanese(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            subtitle2: GoogleFonts.notoSansJavanese(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyText1: GoogleFonts.notoSansJavanese(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyText2: GoogleFonts.notoSansJavanese(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            button: GoogleFonts.notoSansJavanese(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
            caption: GoogleFonts.notoSansJavanese(
                fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.4),
            overline: GoogleFonts.notoSansJavanese(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          )),
      home: const HomeScreen(),
    );
  }
}
