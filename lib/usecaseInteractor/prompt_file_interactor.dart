import 'dart:io';

import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';
import 'package:stable_diffusion_prompt_collector/usecase/image_file.dart';

class PromptFileInteractor {
  static List<File> getImageFileListFromPromptData({
    required PromptData data,
    required bool isImg2Img,
  }) {
    if (isImg2Img && data.parentImgUrl == '') {
      return [];
    } else if (isImg2Img) {
      return ImageFileUseCase.getImageFilesFromPathList([data.parentImgUrl!]);
    } else {
      return ImageFileUseCase.getImageFilesFromPathList(data.imgUrlList);
    }
  }

  // static void add
}
