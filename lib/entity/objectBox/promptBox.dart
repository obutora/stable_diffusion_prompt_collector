import 'package:stable_diffusion_prompt_collector/objectbox.g.dart';

class PromptBox {
  static late final Store store;

  static Future<Store> create() async {
    final store = await openStore();
    return store;
  }
}
