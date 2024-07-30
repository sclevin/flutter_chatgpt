import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chatgpt/injection.dart';
import 'package:flutter_chatgpt/models/message.dart';
import 'package:flutter_chatgpt/models/session.dart';
import 'package:flutter_chatgpt/widgets/message_item_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/30

class ExportService {
  Future<String?> exportMarkdown(Session session,
      {
        String? fileName,
        String? path
      }) async {
    final messages = await db.messageDao.findMessagesBySessionId(session.id!);
    final sb = StringBuffer();
    for (var message in messages) {
      var content = message.content;
      if (message.sender == MessageSenderType.user) {
        content = "> $content"; // markdown 引用，区分消息内容是否是用户的
      }
      sb.writeln();
      sb.writeln(content);
    }

    logger.i(sb.toString());

    final docDir = await getApplicationDocumentsDirectory();
    final exportDir = Directory("${docDir.path}/exports/markdown");
    await exportDir.create(recursive: true);

    final saveFileName =
        fileName ?? '${session.title.replaceAll(RegExp(r'[^\w\s]'), '')}.md';
    final file = File(path ?? "${exportDir.path}/$saveFileName");
    logger.d("export markdown path: ${file.path}");

    await file.writeAsString(sb.toString());
    return file.path;
  }

  // Future<String?> exportImage(Session session, BuildContext context,
  //     {String? fileName}) async {
  //   final messages = await db.messageDao.findMessagesBySessionId(session.id!);
  //   final controller = ScreenshotController();
  //
  //   final key = GlobalKey();
  //   var myLongWidget = Builder(builder: (context) {
  //     return Container(
  //         padding: const EdgeInsets.all(30.0),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.blueAccent, width: 5.0),
  //           color: Colors.redAccent,
  //         ),
  //
  //         ///
  //         /// Note: Do not use Scrolling widget, instead place your children in Column.
  //         ///
  //         /// Do not use widgets like 'Expanded','Flexible',or 'Spacer'
  //         ///
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: messages
  //               .map((message) => [
  //                     message.sender == MessageSenderType.user
  //                         ? SendMessageItemWidget(message: message)
  //                         : ReceivedMessageItemWidget(message: message)
  //                   ])
  //               .expand((element) => element)
  //               .toList(),
  //         ));
  //   });
  //
  //   ///
  //   /// Step 2:
  //   ///    Use `captureFromLongWidget` function for taking screenshot.
  //   ///
  //   var capturedImage = await controller.captureFromLongWidget(
  //     InheritedTheme.captureAll(
  //       context,
  //       Material(
  //         child: myLongWidget,
  //       ),
  //     ),
  //     delay: Duration(milliseconds: 100),
  //     context: context,
  //
  //     ///
  //     /// Additionally you can define constraint for your image.
  //     ///
  //     /// constraints: BoxConstraints(
  //     ///   maxHeight: 1000,
  //     ///   maxWidth: 1000,
  //     /// )
  //   );
  //
  //   final docDir = await getApplicationDocumentsDirectory();
  //   final exportDir = Directory("${docDir.path}/exports/images");
  //   await exportDir.create(recursive: true);
  //   final saveFileName = fileName ??
  //       'img-${session.title.replaceAll(RegExp(r'[^\w\s]'), '')}.png';
  //   final file = File("${exportDir.path}/$saveFileName");
  //   logger.d("export image path: ${file.path}");
  //   await file.writeAsBytes(capturedImage);
  //   return file.path;
  // }
}
