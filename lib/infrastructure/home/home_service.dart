import 'dart:io';

import 'package:dio/dio.dart';
import 'package:machine_test/core/api_end_points.dart';
import 'package:machine_test/domain/image_model/image_response.dart';

class HomeService {
  Future<(String, ImageResponse?)> getImageFromServer() async {
    try {
      final Response response = await Dio().get(ApiEndPoints.randomImageApi);

      if (response.statusCode == 200) {
        final imageUrl = ImageResponse.fromJson(response.data);

        return ('', imageUrl);
      } else {
        return ('response is there but issue', null);
      }
    } catch (e) {
      if (e is DioException) {
        if (e.error is SocketException) {
          return ('Internet Connectivity error', null);
        } else if (e.response?.statusCode == 404) {
          return ('Server is offline', null);
        }
      }

      return ('Please try after sometime', null);
    }
  }
}
