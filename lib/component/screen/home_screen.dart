import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/component/textField/prompt_text_field.dart';
import 'package:stable_diffusion_prompt_collector/entity/objectBox/promptBox.dart';
import 'package:stable_diffusion_prompt_collector/error_boundary/can_add_prompt.dart';
import 'package:stable_diffusion_prompt_collector/usecase/prompt_usecase.dart';
import 'package:stable_diffusion_prompt_collector/usecaseInteractor/temp_prompt_interactor.dart';

import '../../provider/temp_prompt_data_provider.dart';
import '../card/prompt_image_list_card.dart';
import '../theme/colors.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempPrompt = ref.watch(tempPromptProvider);
    final tempPromptNotifier = ref.watch(tempPromptProvider.notifier);

    final canAddState = useState(CanAddPrompt.init);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: zinc900,
        elevation: 0,
        title: Text(
          'Stable Diffusion Prompt Collctor',
          style: Theme.of(context).textTheme.button!.copyWith(color: white200),
        ),
      ),
      drawer: const Drawer(),
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
              const SizedBox(height: 40),
              Text(
                'Add your Art',
                style: Theme.of(context).textTheme.headline5,
              ),
              const PromptImageListCard(
                isImg2Img: false,
              ),
              const SizedBox(height: 40),
              Text(
                'txt2img or img2img?',
                style: Theme.of(context).textTheme.headline5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Switch(
                      activeColor: Colors.indigoAccent,
                      value: tempPrompt.isImg2Img,
                      onChanged: (_) {
                        tempPromptNotifier.changeIsImg2Img();
                      }),
                  Text(
                    'If you are using Img2Img, switch it on.',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: white400),
                  ),
                ],
              ),
              tempPrompt.isImg2Img
                  ? Padding(
                      padding: const EdgeInsets.only(left: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            'Add parent image',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          const PromptImageListCard(
                            isImg2Img: true,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 20),
              Text(
                'Prompt',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 8),
              PromptTextField(
                onChange: (String prompt) {
                  tempPromptNotifier.updatePrompt(prompt);
                },
              ),
              const SizedBox(
                height: 40,
              ),
              //NOTE : Save Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  final canAdd = PromptUseCase.canAdd(tempPrompt);
                  canAddState.value = canAdd;

                  if (canAdd == CanAddPrompt.ok) {
                    TempPromptInteractor.addBox(data: tempPrompt);
                    tempPromptNotifier.clear();
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: white200,
                        ),
                  ),
                ),
              ),
              canAddState.value == CanAddPrompt.init ||
                      canAddState.value == CanAddPrompt.ok
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        canAddState.value.errorText,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.redAccent),
                      ),
                    ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  final list = PromptBox.getAll();
                  print(list);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    'Test',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: white200,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      ),
    );
  }
}
