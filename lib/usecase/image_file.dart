import 'dart:io';

class ImageFileUseCase {
  static File getImageFileFromAssets(String path) {
    return File(path);
  }

  static List<File> getImageFilesFromPathList(List<String> pathList) {
    List<File> fileList = [];
    for (String path in pathList) {
      fileList.add(getImageFileFromAssets(path));
    }

    return fileList;
  }
}
