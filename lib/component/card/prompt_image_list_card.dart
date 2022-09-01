import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/provider/temp_prompt_data_provider.dart';
import 'package:stable_diffusion_prompt_collector/usecase/image_file.dart';

class PromptImageListCard extends ConsumerWidget {
  const PromptImageListCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempPrompt = ref.watch(tempPromptProvider);
    final tempPromptNotifier = ref.watch(tempPromptProvider.notifier);

    if (tempPrompt.imgUrlList.isEmpty) {
      return const SizedBox();
    } else {
      final files =
          ImageFileUseCase.getImageFilesFromPathList(tempPrompt.imgUrlList);
      // return Image.file(files[0]);
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: files
            .map((File file) => Stack(
                  children: [
                    Image.file(
                      file,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                        top: 4,
                        right: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8)),
                            color: Colors.redAccent,
                          ),
                          child: IconButton(
                            onPressed: () {
                              tempPromptNotifier.deleteImgUrl(file.path);
                            },
                            icon: const Icon(
                              CupertinoIcons.xmark_circle,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ))
            .toList(),
      );
    }
  }
}
