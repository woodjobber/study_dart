import 'dart:io';

import 'package:dio/dio.dart';
import 'package:study_dart/retry_interceptor/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor({
    required this.requestRetrier,
  });
  final DioConnectivityRequestRetrier requestRetrier;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        final response =
            await requestRetrier.scheduleRequestRetry(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (e) {
        return handler.next(e);
      } catch (e, s) {
        final dioException = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: e,
          stackTrace: s,
          message: err.message,
          type: err.type,
        );
        return handler.next(dioException);
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionError &&
        error.error != null &&
        error.error is SocketException;
  }
}
