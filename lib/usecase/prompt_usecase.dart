import 'package:desktop_drop/src/drop_target.dart';
import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';
import 'package:stable_diffusion_prompt_collector/error_boundary/can_add_prompt.dart';

class PromptUseCase {
  static PromptData addDrugImageDetailesToPromptBoxProperty(
      DropDoneDetails details, PromptData promptData) {
    // print(details.files);

    for (var file in details.files) {
      final name = file.name;
      promptData.imgUrlList.add(name);
    }

    return promptData;
  }

  static CanAddPrompt canAdd(PromptData data) {
    if (data.prompt == '') {
      return CanAddPrompt.noPrompt;
    }

    if (data.imgUrlList.isEmpty) {
      return CanAddPrompt.noImg;
    }

    if (data.isImg2Img && data.parentImgUrl == '') {
      return CanAddPrompt.noParentImg;
    }

    return CanAddPrompt.ok;
  }
}
