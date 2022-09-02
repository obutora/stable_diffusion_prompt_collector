import 'package:stable_diffusion_prompt_collector/entity/objectBox/promptBox.dart';
import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';
import 'package:stable_diffusion_prompt_collector/provider/temp_prompt_data_provider.dart';
import 'package:stable_diffusion_prompt_collector/usecase/image_file.dart';

class TempPromptInteractor {
  static Future addImageToTempPrompt({
    required TempPromptNotifier notifier,
    required bool isImg2Img,
    required List<String> pathList,
  }) async {
    if (isImg2Img) {
      final String name = pathList[0];
      notifier.updateParentImgUrl(name);
    } else {
      notifier.addImgUrlList(pathList);
    }
  }

  static void removeImageFromTempPrompt({
    required TempPromptNotifier notifier,
    required bool isImg2Img,
    String? path,
  }) {
    if (isImg2Img) {
      notifier.deleteParentImgUrl();
    } else {
      assert(path != null);
      notifier.deleteImgUrl(path!);
    }
  }

  static bool checkExistImgUrl({
    required PromptData data,
    required bool isImg2Img,
  }) {
    if (isImg2Img) {
      final bool isExist = data.parentImgUrl != '' ? true : false;
      return isExist;
    } else {
      final bool isExist = data.imgUrlList.isNotEmpty ? true : false;
      return isExist;
    }
  }

  static void addBox({required PromptData data}) {
    final imgList = ImageFileUseCase.getSavedPathList(data.imgUrlList);

    final String parentImgUrl = data.isImg2Img
        ? ImageFileUseCase.getSavedPathList([data.parentImgUrl!])[0]
        : '';

    final PromptData newData = data.copyWith(
      imgUrlList: imgList,
      parentImgUrl: parentImgUrl,
      updateAt: DateTime.now(),
    );

    PromptBox.add(newData);
  }
}
