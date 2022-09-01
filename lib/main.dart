import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/component/card/prompt_image_list_card.dart';
import 'package:stable_diffusion_prompt_collector/component/theme/colors.dart';
import 'package:stable_diffusion_prompt_collector/entity/objectBox/promptBox.dart';
import 'package:stable_diffusion_prompt_collector/provider/temp_prompt_data_provider.dart';
import 'package:stable_diffusion_prompt_collector/usecase/prompt_usecase.dart';

import 'component/textField/prompt_text_field.dart';

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

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempPrompt = ref.watch(tempPromptProvider);
    final tempPromptNotifier = ref.watch(tempPromptProvider.notifier);

    return Scaffold(
      backgroundColor: zinc800,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 80, right: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resister Prompt',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                'Register prompts and images to generate more beautiful images.',
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: white400),
              ),
              const PromptImageListCard(),
              // tempImageFileList.value.isNotEmpty
              //     ? Image.file(tempImageFileList.value[0])
              //     : const SizedBox(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DropTarget(
                  onDragEntered: ((details) {}),
                  onDragDone: ((details) async {
                    final fileNames = details.files.map((e) => e.path).toList();
                    print(fileNames);
                    tempPromptNotifier.addImgUrlList(fileNames);
                    PromptUseCase.addDrugImageDetailesToPromptBoxProperty(
                        details, tempPrompt);

                    // for (var file in details.files) {
                    //   final fileData =
                    //       await ImageFileUseCase.getImageFileFromAssets(
                    //           file.path);
                    //   tempImageFileList.value.add(fileData);
                    //   print(tempImageFileList.value);
                    // }
                  }),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: zinc500,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 300,
                    height: 120,
                    child: Center(
                      child: Text(
                        'Please drag the generated image',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: white200),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Prompt',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 4),
              PromptTextField(
                onChange: (String prompt) {
                  // print(prompt);
                  tempPromptNotifier.updatePrompt(prompt);

                  print(tempPrompt.prompt);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      'Add',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: white200,
                          ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
