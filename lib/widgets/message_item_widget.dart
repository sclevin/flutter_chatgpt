import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/widgets/message_content_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/message.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/19
class ReceivedMessageItemWidget extends StatelessWidget {
  final Message message;
  final Color backgroundColor;
  final double radius;

  const ReceivedMessageItemWidget({
    super.key,
    required this.message,
    this.backgroundColor = Colors.white,
    this.radius = 8
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Container(
            color: Colors.white,
            child: SvgPicture.asset("assets/images/chatgpt.svg"),
          ),
        ),
        const SizedBox(
          width: 8,
        ),

        CustomPaint(
          painter: Triangle(backgroundColor),
        ),

        Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(right: 48),
              child: MessageContentWidget(message:message),
            )
        ),
      ],
    );
  }
}


class SendMessageItemWidget extends StatelessWidget {
  final Message message;
  final Color backgroundColor;
  final double radius;
  const SendMessageItemWidget({
    super.key,
    required this.message,
    this.backgroundColor = Colors.white,
    this.radius = 8
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(radius),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.only(left: 48),
              child: MessageContentWidget(message:message),
            )
        ),
        CustomPaint(
          painter: Triangle(backgroundColor),
        ),
        const SizedBox(
          width: 8,
        ),

        CircleAvatar(
          backgroundColor: Colors.blue,
          child: Container(
            color: Colors.white,
            child: SvgPicture.asset("assets/images/chatgpt.svg"),
          ),
        ),
      ],
    );
  }
}


class Triangle extends CustomPainter {
  final Color bgColor;


  Triangle(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;

    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(5, 10);
    path.lineTo(10, 0);
    canvas.translate(-5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}