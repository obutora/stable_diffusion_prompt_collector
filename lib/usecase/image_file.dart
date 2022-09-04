import 'dart:io';

const String saveFolder = 'assets/promptImg/';

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

  // ローカルから asset/promptImg 内にファイルをコピーしてコピー後のPathを返す
  static List<String> getSavedPathList(List<String> pathList) {
    List<String> savedPathList = [];

    for (String path in pathList) {
      final String name = path.split('\\').last;
      // fileをローカルにコピー
      File(path).copySync('$saveFolder$name');
      savedPathList.add('$saveFolder$name');
    }

    return savedPathList;
  }

  static void removeFile(String path) {
    final dir = Directory(path);
    dir.deleteSync(recursive: true);
  }

  static void removeFileByPathList(List<String> pathList) {
    for (String path in pathList) {
      removeFile(path);
    }
  }
}
