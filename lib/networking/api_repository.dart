

import 'package:fininfocom/RandomImageResponse.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../ProfileResponse.dart';
import 'api_manager.dart';

class ApiRepository {


  getProfileData() async {
    try {
      final response =
      await ApiManager().getProfileResponse();
      if (response != null && response.statusCode == 200) {
        ProfileResponse profileResponse =
        ProfileResponse.fromJson(response.data);
        return profileResponse;
      } else {
        Future.delayed(Duration(milliseconds: 900), () async {
          EasyLoading.showError(response.reasonPhrase);
        });
      }
    } catch (e) {
      Future.delayed(Duration(milliseconds: 900), () async {
        EasyLoading.showError("Error\n $e");
      });
    }
  }


  getImageData() async {
    try {
      final response =
      await ApiManager().getResponseForImage();
      if (response != null && response.statusCode == 200) {
        RandomImageResponse randomImageResponse =
        RandomImageResponse.fromJson(response.data);
        return randomImageResponse;
      } else {
        Future.delayed(Duration(milliseconds: 900), () async {
          EasyLoading.showError(response.reasonPhrase);
        });
      }
    } catch (e) {
      Future.delayed(Duration(milliseconds: 900), () async {
        EasyLoading.showError("Error\n $e");
      });
    }
  }
}