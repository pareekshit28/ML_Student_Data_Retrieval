import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:camera/camera.dart';

class RegisterScreenViewModel {
  Future<List> getFaceData({required XFile image}) async {
    try {
      final bytes = await image.readAsBytes();
      final img = base64Encode(bytes);
      final dio = Dio();
      final response = await dio.post(
          "https://student-details.herokuapp.com/getFaceData",
          data: {"image": img});
      if (response.statusCode == 200) {
        return response.data.values.toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
