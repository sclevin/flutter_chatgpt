import 'package:floor/floor.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/23
@entity
class Session {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;

  Session({this.id, required this.title});

  Session copyWith({int? id, String? title}) {
    return Session(id: id ?? this.id, title: title ?? this.title);
  }
}


