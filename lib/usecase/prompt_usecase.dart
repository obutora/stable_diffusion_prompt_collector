import 'package:desktop_drop/src/drop_target.dart';
import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';

class PromptUseCase {
  static PromptData addDrugImageDetailesToPromptBoxProperty(
      DropDoneDetails details, PromptData promptData) {
    print(details.files);

    for (var file in details.files) {
      final name = file.name;
      promptData.imgUrlList.add(name);
    }

    return promptData;
  }
}
