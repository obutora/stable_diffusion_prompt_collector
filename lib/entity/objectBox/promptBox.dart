import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';
import 'package:stable_diffusion_prompt_collector/objectbox.g.dart';

class PromptBox {
  static late final Store store;
  static final Box<PromptData> box = store.box();

  static Future<Store> create() async {
    store = await openStore();
    return store;
  }

  static void add(PromptData data) {
    box.put(data);
  }

  static void addWithNewPath(PromptData data, List<String> imgList) {
    // box.put(
    //   // PromptData(prompt: data.prompt, updateAt: DateTime.now(), imgUrlList: imgList, rate: 3, isImg2Img: isImg2Img, parentImgUrl: parentImgUrl)
    // );
  }

  static void remove(int id) {
    box.remove(id);
  }

  static List<PromptData> getAll() {
    return box.getAll();
  }
}
