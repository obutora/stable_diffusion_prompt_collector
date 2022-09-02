import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';

class TempPromptNotifier extends StateNotifier<PromptData> {
  TempPromptNotifier()
      : super(
          PromptData(
              prompt: '',
              updateAt: DateTime.now(),
              imgUrlList: [],
              rate: 0,
              isImg2Img: false,
              parentImgUrl: ''),
        );

  void clear() {
    state = PromptData(
        prompt: '',
        updateAt: DateTime.now(),
        imgUrlList: [],
        rate: 0,
        isImg2Img: false,
        parentImgUrl: '');
  }

  void changeIsImg2Img() {
    state = state.copyWith(isImg2Img: !state.isImg2Img);
  }

  void updatePrompt(String prompt) {
    state = state.copyWith(prompt: prompt);
  }

  void updateImgUrlList(List<String> imgUrlList) {
    state = state.copyWith(imgUrlList: imgUrlList);
  }

  void addImgUrlList(List<String> imgUrlList) {
    final List<String> addedImgList = [...state.imgUrlList, ...imgUrlList];
    state = state.copyWith(imgUrlList: addedImgList);
  }

  void deleteImgUrl(String imgUrl) {
    List<String> imgList = state.imgUrlList;
    imgList.remove(imgUrl);

    state = state.copyWith(imgUrlList: imgList);
  }

  void deleteParentImgUrl() {
    state = state.copyWith(parentImgUrl: '');
  }

  void updateNowTime() {
    state = state.copyWith(updateAt: DateTime.now());
  }

  void updateRate(double rate) {
    state = state.copyWith(rate: rate);
  }

  void updateParentImgUrl(String url) {
    state = state.copyWith(isImg2Img: true, parentImgUrl: url);
  }

  void updateData(PromptData data) {
    state = state.copyWith(
      prompt: data.prompt,
      updateAt: data.updateAt,
      imgUrlList: data.imgUrlList,
      rate: data.rate,
      isImg2Img: data.isImg2Img,
      parentImgUrl: data.parentImgUrl,
    );
  }
}

final tempPromptProvider =
    StateNotifierProvider<TempPromptNotifier, PromptData>(
        (ref) => TempPromptNotifier());
