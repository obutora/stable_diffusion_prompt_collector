import 'package:flutter/material.dart';
import 'package:stable_diffusion_prompt_collector/component/scaffold/standard_scaffold.dart';
import 'package:stable_diffusion_prompt_collector/entity/objectBox/promptBox.dart';
import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';
import 'package:stable_diffusion_prompt_collector/usecase/image_file.dart';

import '../theme/colors.dart';

class ViewScreen extends StatelessWidget {
  static const String id = 'ViewScreen';
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PromptData> dataList = PromptBox.getAll();

    return StandardScaffold(
      children: [
        Text(
          'View',
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          'You can view and search your saved Prompts.',
          style: Theme.of(context).textTheme.caption!.copyWith(color: white400),
        ),
        const SizedBox(height: 40),
        ...dataList
            .map((PromptData data) => Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: const BoxDecoration(color: zinc900),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              data.isImg2Img
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'parent image',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption!
                                              .copyWith(color: white400),
                                        ),
                                        Image.file(
                                          ImageFileUseCase
                                              .getImageFileFromAssets(
                                                  data.parentImgUrl!),
                                          height: 100,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'prompt',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(color: white400),
                                  ),
                                  SelectableText(data.prompt,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: white200)),
                                ],
                              ),
                            ],
                          )),
                      Expanded(
                        flex: 256,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          runAlignment: WrapAlignment.start,
                          children: data.imgUrlList
                              .map(
                                (String path) => Image.file(
                                  ImageFileUseCase.getImageFileFromAssets(path),
                                  height: 200,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ],
    );
  }
}
