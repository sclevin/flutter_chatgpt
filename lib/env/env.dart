import 'package:envied/envied.dart';

/// Description:
/// Author:LiaoWen
/// Date:2024/7/18

part 'env.g.dart';

@Envied(path: ".env")
abstract class Env{

  @EnviedField(varName: "API_KEY")
  static const String apiKey = _Env.apiKey;

  @EnviedField(varName: "HTTP_PROXY",defaultValue: '')
  static const String httpProxy = _Env.httpProxy;

  @EnviedField(varName: "BASE_URL",defaultValue: '')
  static const String baseUrl = _Env.baseUrl;
}