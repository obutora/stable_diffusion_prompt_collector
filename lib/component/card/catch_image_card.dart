import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/temp_prompt_data_provider.dart';
import '../../usecase/prompt_usecase.dart';
import '../theme/colors.dart';

class CatchImageCard extends ConsumerWidget {
  const CatchImageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempPrompt = ref.watch(tempPromptProvider);
    final tempPromptNotifier = ref.watch(tempPromptProvider.notifier);

    return DropTarget(
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
