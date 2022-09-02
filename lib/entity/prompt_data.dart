import 'package:objectbox/objectbox.dart';

@Entity()
class PromptData {
  int id = 0;
  final String prompt;
  final DateTime updateAt;
  final List<String> imgUrlList;
  final double rate;
  final bool isImg2Img;
  final String? parentImgUrl;

  PromptData({
    required this.prompt,
    required this.updateAt,
    required this.imgUrlList,
    required this.rate,
    required this.isImg2Img,
    required this.parentImgUrl,
  });

  PromptData copyWith({
    String? prompt,
    DateTime? updateAt,
    List<String>? imgUrlList,
    double? rate,
    bool? isImg2Img,
    String? parentImgUrl,
  }) {
    return PromptData(
        prompt: prompt ?? this.prompt,
        updateAt: updateAt ?? this.updateAt,
        imgUrlList: imgUrlList ?? this.imgUrlList,
        rate: rate ?? this.rate,
        isImg2Img: isImg2Img ?? this.isImg2Img,
        parentImgUrl: parentImgUrl ?? this.parentImgUrl);
  }

  @override
  String toString() =>
      '\nPromptData(id: $id, isImg2Img: $isImg2Img, imgUrlList: $imgUrlList, parentImgUrl: $parentImgUrl)\n';
}
