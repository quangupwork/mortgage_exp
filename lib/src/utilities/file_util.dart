import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:mortgage_exp/src/utilities/showtoast.dart';
import 'package:mortgage_exp/src/utilities/utilities.dart';

enum FileType { document, image, video, gif }

class FileUtil {
  static FileType? getFbUrlFileType(String path) {
    if (path.toLowerCase().contains('.png') ||
        path.toLowerCase().contains('.jpg') ||
        path.toLowerCase().contains('.img') ||
        path.toLowerCase().contains('.jpeg') ||
        path.toLowerCase().contains('.webp')) return FileType.image;
    if (path.toLowerCase().contains('.mp4') || path.contains('.wmv')) {
      return FileType.video;
    }
    if (path.toLowerCase().contains('.doc')) return FileType.document;
    if (path.toLowerCase().contains('.gif')) return FileType.gif;
  }

  static FileType? getFilePathType(String path) {
    if (p.extension(path).toLowerCase() == '.png' ||
        p.extension(path).toLowerCase() == '.jpg' ||
        p.extension(path).toLowerCase() == '.img' ||
        p.extension(path).toLowerCase() == '.jpeg' ||
        p.extension(path).toLowerCase() == '.webp') return FileType.image;
    if (p.extension(path).toLowerCase() == '.mp4' ||
        p.extension(path).toLowerCase() == '.wmv') return FileType.video;
    if (p.extension(path).toLowerCase() == '.doc') return FileType.document;
    if (p.extension(path).toLowerCase() == '.gif') return FileType.gif;
  }

  static Future<File> resizeImage(Uint8List data, int resizeWidth) async {
    img.Image image = img.decodeImage(data)!;

    // Resize the image to a 240? thumbnail (maintaining the aspect ratio).
    img.Image thumbnail = img.copyResize(image, width: resizeWidth);

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/thumbnail.jpg';
    return File(filePath)..writeAsBytesSync(img.encodePng(thumbnail));
  }

  static Future<File> resizeImageOverride(
      String filePath, int resizeWidth) async {
    img.Image image = img.decodeImage(File(filePath).readAsBytesSync())!;

    // Resize the image to a 240? thumbnail (maintaining the aspect ratio).
    img.Image thumbnail = img.copyResize(image, width: resizeWidth);

    return File(filePath)..writeAsBytesSync(img.encodePng(thumbnail));
  }

  static Future<String> uploadFireStorage(String filePath,
      {String? path, bool isResize = true, int resizeWidth = 1080}) async {
    if (filePath.isEmpty) return '';
    File file = File(filePath);
    if ((await file.length()) > 20 * 1024 * 1024) {
      ToastView.show(
          'File có kích thước quá lớn, vui lòng upload file có dung lương < 20MB');
      return '';
    }

    try {
      // Resize image

      // if (isResize &&
      //     getFbUrlFileType(Path.basename(filePath)) == FileType.image) {
      //   file = await resizeImageOverride(filePath, resizeWidth);
      // }
      Reference storageReference = FirebaseStorage.instance.ref().child(
          '${path ?? 'root'}/${DateTime.now().toString().replaceAll(' ', '')}${changeImageToJpg(p.basename(file.path)).replaceAll(RegExp(r'(\?alt).*'), '').replaceAll(' ', '')}');
      UploadTask uploadTask = storageReference.putFile(file);
      LoggerUtils.d('uploading...');
      await uploadTask.whenComplete(() {});
      LoggerUtils.d('File Uploaded');
      final fileURL = await storageReference.getDownloadURL();
      return fileURL;
    } catch (e) {
      throw Exception("Upload file thất bại. Xin vui lòng thử lại");
    }
  }

  static String changeImageToJpg(String name) {
    if (getFilePathType(name) == FileType.image) {
      return name.replaceAll(p.extension(name), '.jpg');
    }
    return name;
  }

  static Future<bool> deleteFileFireStorage(String path) async {
    if (path.isEmpty) return false;
    String filePath = path;
    try {
      Reference storageReference =
          FirebaseStorage.instance.refFromURL(filePath);
      LoggerUtils.d(filePath);
      LoggerUtils.d(storageReference);
      await storageReference.delete();
      return true;
    } catch (e) {
      ToastView.show(e.toString());
      return false;
    }
  }
}
