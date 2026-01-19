import 'package:dio/dio.dart';
import 'package:flutter_application/providers/auth_interceptor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class ApiClient {
  final Logger logger = Logger();
  final Dio _dio;

  ApiClient() : _dio = Dio() {
    _dio.options.baseUrl = dotenv.env['BASE_URL'] ?? 'default_url';
    
    _dio.interceptors.add(AuthInterceptor(_dio));
    
    _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  }

  // Metodo generico per le chiamate GET
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      logger.e('Errore nella chiamata GET a $path: $e');
      rethrow;
    }
  }
  
  // Metodo generico per le chiamate POST
  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      logger.e('Errore nella chiamata POST a $path: $e');
      rethrow;
    }
  }

    // Metodo generico per le chiamate DELETE
  Future<Response> delete(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.delete(path, data: data, options: options);
    } on DioException catch (e) {
      logger.e('Errore nella chiamata POST a $path: $e');
      rethrow;
    }
  }
}