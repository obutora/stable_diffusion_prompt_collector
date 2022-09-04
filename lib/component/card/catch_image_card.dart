import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/usecaseInteractor/temp_prompt_interactor.dart';

import '../../provider/temp_prompt_data_provider.dart';
import '../theme/colors.dart';

class CatchImageCard extends ConsumerWidget {
  const CatchImageCard({
    Key? key,
    required this.isImg2Img,
  }) : super(key: key);

  final bool isImg2Img;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final tempPrompt = ref.watch(tempPromptProvider);
    final tempPromptNotifier = ref.watch(tempPromptProvider.notifier);
    bool isloading = false;

    return DropTarget(
      onDragEntered: ((details) {}),
      onDragDone: ((details) async {
        if (isloading == false) {
          isloading = true;

          final pathList = details.files.map((e) => e.path).toList();
          // tempPromptNotifier.addImgUrlList(pathList);
          await TempPromptInteractor.addImageToTempPrompt(
              notifier: tempPromptNotifier,
              isImg2Img: isImg2Img,
              pathList: pathList);

          isloading = false;
        }
      }),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: zinc500,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 200,
        height: 200,
        child: Center(
          child: Text(
            'Please drag the image',
            style:
                Theme.of(context).textTheme.caption!.copyWith(color: white200),
          ),
        ),
      ),
    );
  }
}
