import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stable_diffusion_prompt_collector/usecase/image_file.dart';

class PromptImage extends StatelessWidget {
  const PromptImage({
    Key? key,
    required this.path,
  }) : super(key: key);

  final String path;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.indigoAccent,
      focusColor: Colors.indigoAccent,
      onTap: () {
        print('tap');

        showDialog(
          context: context,
          builder: (context) {
            return Center(
              child: Stack(
                children: [
                  SizedBox(
                    child: InteractiveViewer(
                      minScale: 0.1,
                      maxScale: 5,
                      child: Image.file(
                        ImageFileUseCase.getImageFileFromAssets(path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 8,
                      left: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            color: Colors.black87,
                            icon: const Icon(CupertinoIcons.chevron_back),
                            onPressed: (() => Navigator.pop(context)),
                          ),
                        ),
                      ))
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            ImageFileUseCase.getImageFileFromAssets(path),
            height: 200,
            width: 200,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
