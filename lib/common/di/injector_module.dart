// // ignore_for_file: avoid_classes_with_only_static_members
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';
// import 'package:day_planner/common/services/services.dart';
// import 'package:day_planner/common/utils/app_utils.dart';
// import 'package:day_planner/features/app_update/mixin/app_version_mixin.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pub_semver/pub_semver.dart';
//
// import '../../features/posts/services/services.dart';
// import '../../network/network.dart';
// import '../../network/refresh_token/dio_token_request_retrier.dart';
//
// part '../../network/dio_bootstrapper.dart';
//
// class InjectorModule {
//   static GetIt locator = GetIt.asNewInstance();
//
//   static Future<void> inject() async {
//     final credentials = await loadCredentials();
//     GetIt.I.registerLazySingleton<Credentials>(() => credentials);
//
//     final literalAppVersion = await getApplicationVersion();
//     final currentAppVersion = Version.parse(literalAppVersion ?? AppVersionMixin.minFallbackVersion);
//     GetIt.I.registerLazySingleton<Version>(() => currentAppVersion);
//
//     final dio = await _DioBootstrapper().setupDio(credentials: credentials);
//
//     locator.registerSingleton<Dio>(dio);
//
//     locator.registerFactory<ApiClient>(
//       () => ApiClientImpl(
//         dio: locator(),
//       ),
//     );
//     locator.registerFactory<PostsApiService>(
//       () => PostsApiServiceImpl(
//         locator(),
//       ),
//     );
//     // locator.registerFactory<WebSocketService>(
//     //   () => WebSocketService(
//     //     webSocketClient: locator(),
//     //   ),
//     // );
//   }
// }
