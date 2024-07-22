import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/markdown/latex.dart';
import 'package:flutter_chatgpt/models/message.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../markdown/code_wrapper.dart';

class MessageContentWidget extends StatelessWidget {
  final Message message;
  const MessageContentWidget({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
     codeWrapper(child,text,language) => CodeWrapperWidget(child: child, text: text);
    return SelectionArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: MarkdownGenerator(
          generators: [
            latexGenerator
          ],
          inlineSyntaxList: [
            LatexSyntax()
          ]
      )
          .buildWidgets(message.content,config: MarkdownConfig(configs: [PreConfig().copy(wrapper: codeWrapper)])),
    ));
  }
}
