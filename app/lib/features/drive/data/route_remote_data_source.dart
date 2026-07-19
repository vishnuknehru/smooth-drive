import 'package:dio/dio.dart';

import '../../../core/network/api_client.dart';
import '../domain/entities/route_analysis.dart';
import 'dto/route_dtos.dart';

class RouteRemoteDataSource {
  RouteRemoteDataSource(this._dio);

  final Dio _dio;

  Future<RouteAnalysisDto> analyze({
    required Coord start,
    required Coord end,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/api/route/analyze',
        data: {
          'start': {'lat': start.lat, 'lon': start.lon},
          'end': {'lat': end.lat, 'lon': end.lon},
        },
      );
      return RouteAnalysisDto.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<UpcomingResponseDto> upcoming({
    required String routeId,
    required Coord position,
    double? speedMph,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/api/position/upcoming',
        data: {
          'route_id': routeId,
          'lat': position.lat,
          'lon': position.lon,
          'speed_mph': ?speedMph,
        },
      );
      return UpcomingResponseDto.fromJson(response.data!);
    } on DioException catch (e) {
      throw mapDioError(e);
    }
  }

  Future<bool> health() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/health');
      return response.data?['status'] == 'ok';
    } on DioException {
      return false;
    }
  }
}
