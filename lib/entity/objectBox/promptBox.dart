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

  static List<PromptData> searchByPrompt(String word) {
    // , は無駄な情報なのでここで削除しておく
    word = word.replaceAll(',', '');

    final query = (box.query(PromptData_.prompt.contains(word))
          ..order(PromptData_.updateAt))
        .build();

    final result = query.find();
    query.close();

    return result;
  }
}
