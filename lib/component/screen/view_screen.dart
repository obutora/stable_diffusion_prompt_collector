import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stable_diffusion_prompt_collector/component/scaffold/standard_scaffold.dart';
import 'package:stable_diffusion_prompt_collector/entity/objectBox/promptBox.dart';
import 'package:stable_diffusion_prompt_collector/entity/prompt_data.dart';
import 'package:stable_diffusion_prompt_collector/provider/temp_prompt_data_provider.dart';
import 'package:stable_diffusion_prompt_collector/usecase/image_file.dart';
import 'package:stable_diffusion_prompt_collector/usecaseInteractor/temp_prompt_interactor.dart';

import '../theme/colors.dart';

class ViewScreen extends ConsumerWidget {
  static const String id = 'ViewScreen';
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(tempPromptProvider.notifier);
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
        dataList.isEmpty
            ? Text(
                'No Data',
                style: Theme.of(context).textTheme.headline5,
              )
            : const SizedBox(),
        ...dataList
            .map(
              (PromptData data) => Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                        color: zinc900,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          const SizedBox(height: 4),
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
                                  height: 28,
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
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Wrap(children: [
                                      ...data.prompt
                                          .split(' ')
                                          .map(
                                            (String word) => Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                    color: zinc800,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    word,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: white200),
                                                  ),
                                                )),
                                          )
                                          .toList(),
                                    ])
                                    // SelectableText(
                                    //   data.prompt,
                                    //   style: Theme.of(context)
                                    //       .textTheme
                                    //       .bodyText1!
                                    //       .copyWith(color: white200),
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        foregroundColor: Colors.indigoAccent,
                                        backgroundColor: zinc500,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 8)),
                                    onPressed: () async {
                                      final clip =
                                          ClipboardData(text: data.prompt);

                                      await Clipboard.setData(clip);
                                    },
                                    icon: const Icon(
                                      CupertinoIcons
                                          .rectangle_fill_on_rectangle_fill,
                                      color: white200,
                                    ),
                                    label: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(4, 8, 4, 4),
                                      child: Text(
                                        'Copy Prompt',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(color: white200),
                                      ),
                                    ))
                              ],
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 256,
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            spacing: 12,
                            runSpacing: 12,
                            children: data.imgUrlList
                                .map(
                                  (String path) => Image.file(
                                    ImageFileUseCase.getImageFileFromAssets(
                                        path),
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 8,
                      right: 8,
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(
                              CupertinoIcons.trash,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: zinc800,
                                  content: Text(
                                    'You want to remove this prompt and images?',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(color: white200),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(color: white400),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        TempPromptInteractor
                                            .removePromptAndFile(
                                                data: data, notifier: notifier);
                                        Navigator.pushNamed(
                                            context, ViewScreen.id);
                                      },
                                      child: Text(
                                        'Delete',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button!
                                            .copyWith(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Text(
                            'delete',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: white400),
                          )
                        ],
                      )),
                ],
              ),
            )
            .toList()
      ],
    );
  }
}
