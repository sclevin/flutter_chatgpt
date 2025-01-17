import 'package:floor/floor.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23
@entity
class Session {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String model;

  Session({
    this.id,
    required this.title,
    required this.model
  });

  Session copyWith({int? id, String? title,String? model}) {
    return Session(id: id ?? this.id, title: title ?? this.title,model: model ?? this.model);
  }
}


