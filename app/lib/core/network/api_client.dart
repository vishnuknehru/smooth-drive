import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/settings/presentation/settings_controller.dart';
import '../config/app_config.dart';
import '../error/failure.dart';

part 'api_client.g.dart';

/// Rebuilds automatically when the user edits the server URL in Settings.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final baseUrl = ref.watch(baseUrlProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
    ),
  );
  if (kDebugMode) {
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
  }
  ref.onDispose(dio.close);
  return dio;
}

Failure mapDioError(DioException e) => switch (e.type) {
  DioExceptionType.connectionTimeout ||
  DioExceptionType.sendTimeout ||
  DioExceptionType.receiveTimeout ||
  DioExceptionType.connectionError => const NetworkFailure(),
  DioExceptionType.badResponse => switch (e.response?.statusCode) {
    404 => const RouteExpiredFailure(),
    422 => const ValidationFailure(),
    502 => const UpstreamFailure(),
    final code => UnknownFailure('Server error ($code)'),
  },
  _ => UnknownFailure(e.message ?? 'Unexpected network error'),
};
