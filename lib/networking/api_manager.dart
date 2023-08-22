
import 'package:dio/dio.dart';

class ApiManager {
  var dio;
  static const BASE_URL_IMAGE ="https://dog.ceo/api/breeds/image/random";
  static const PROFILE_URL ="https://randomuser.me/api/";

  //Get
  getResponseForImage() async {
    try {
      dio ??= Dio();

      final response = await dio.get(BASE_URL_IMAGE);

      return response;
    } catch (e) {
      print("Error\n $e");
    }

    return null;
  }

  getProfileResponse() async {
    try {
      dio ??= Dio();
      final response = await dio.get(PROFILE_URL);

      return response;
    } catch (e) {
      print("Error\n $e");
    }

    return null;
  }



}

