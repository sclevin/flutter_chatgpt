import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:openai_api/openai_api.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/25

class GptModelWidget extends HookWidget {
  final String? active;
  final Function(String model)? onModelChange;

  const GptModelWidget({
    super.key,
    required this.active,
    this.onModelChange
  });



  @override
  Widget build(BuildContext context) {
    final state = useState<String>(Models.gpt3_5Turbo);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Model: '),
        active == null
            ? DropdownButton<String>(
          items: [Models.gpt3_5Turbo, Models.gpt4].map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(e),
            );
          }).toList(),
          value: state.value,
          onChanged: (String? value) {
            if(value == null) return;
            state.value = value;
            onModelChange?.call(value);
          },
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(active ?? ""),
        ),
      ],
    );
  }
}

