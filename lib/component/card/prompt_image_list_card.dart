import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/component/card/catch_image_card.dart';
import 'package:stable_diffusion_prompt_collector/provider/temp_prompt_data_provider.dart';
import 'package:stable_diffusion_prompt_collector/usecaseInteractor/prompt_file_interactor.dart';
import 'package:stable_diffusion_prompt_collector/usecaseInteractor/temp_prompt_interactor.dart';

class PromptImageListCard extends ConsumerWidget {
  const PromptImageListCard({Key? key, required this.isImg2Img})
      : super(key: key);

  final bool isImg2Img;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tempPrompt = ref.watch(tempPromptProvider);
    final tempPromptNotifier = ref.watch(tempPromptProvider.notifier);

    final bool isExistImg = TempPromptInteractor.checkExistImgUrl(
        data: tempPrompt, isImg2Img: isImg2Img);

    if (!isExistImg) {
      return CatchImageCard(isImg2Img: isImg2Img);
    } else {
      final files = PromptFileInteractor.getImageFileListFromPromptData(
        data: tempPrompt,
        isImg2Img: isImg2Img,
      );
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ...files
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
                                // tempPromptNotifier.deleteImgUrl(file.path);
                                TempPromptInteractor.removeImageFromTempPrompt(
                                  notifier: tempPromptNotifier,
                                  isImg2Img: isImg2Img,
                                  path: file.path,
                                );
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
          CatchImageCard(isImg2Img: isImg2Img)
        ],
      );
    }
  }
}
