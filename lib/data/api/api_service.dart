import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

late Dio dio;

class ApiService {
  static const baseUrl = 'https://api.nasa.gov/mars-photos/api/v1/rovers';
  static const apiKey = 'PoFhQ6XaJnSADCnigbyVwiYdAeFhaeuYYMM4rlLn';

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        receiveDataWhenStatusError: true,
        method: 'GET',
        queryParameters: {
          'api_key': apiKey,
        },
      ),
    );
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: log, // show error in console
        retries: 5,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
          Duration(seconds: 4),
          Duration(seconds: 5),
        ],
        retryableExtraStatuses: {status403Forbidden},
      ),
    );
  }

  Future<List<dynamic>> fetchLatestPhotos() async {
    try {
      final Response response = await dio.request("/curiosity/latest_photos");
      log(response.data['latest_photos'].toString());
      return response.data['latest_photos'];
    } catch (e) {
      if (e is DioException) {
        log(e.message.toString());
      } else {
        log('normal error $e');
      }
      return [];
    }
  }

  Future<List<dynamic>> fetchDatePhotos(
      {required String earthDate,required int page}) async {
    try {
      final Response response = await dio.request("/curiosity/photos",
          queryParameters: {"earth_date": earthDate, "page": page});
      return response.data['photos'];
    } catch (e) {
      if (e is DioException) {
        log(e.message.toString());
      } else {
        log('normal error $e');
      }
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchRoverDetails() async {
    try {
      final Response response = await dio.request("/curiosity");
      return response.data['rover'];
    } catch (e) {
      if (e is DioException) {
        log(e.message.toString());
      } else {
        log('normal error $e');
      }
      return {};
    }
  }
}
