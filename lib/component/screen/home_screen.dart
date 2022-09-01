import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/component/textField/prompt_text_field.dart';

import '../../provider/temp_prompt_data_provider.dart';
import '../card/prompt_image_list_card.dart';
import '../theme/colors.dart';

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
              const SizedBox(height: 20),
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
