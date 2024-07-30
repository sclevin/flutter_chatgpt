import 'package:file_picker/file_picker.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/30

Future<String?> saveAs({String? fileName}) async {
  String? outputFile = await FilePicker.platform.saveFile(
    dialogTitle: 'Please select an output file:',
    fileName: fileName ?? 'untitled',
  );

  if (outputFile == null) {
    // User canceled the picker
  }

  return outputFile;
}