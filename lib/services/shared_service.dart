import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx/models/login_response.dart';
import 'package:getx/views/login_page.dart';

class SharedService{
  static Future<bool> isLoggedIn() async{
    var isKeyExist=
        await APICacheManager().isAPICacheKeyExist('login_details');
    return isKeyExist;
  }

  static Future<LoginResponseModel?> loginDetails() async{
    var isKeyExist=
        await APICacheManager().isAPICacheKeyExist('login_details');

    if(isKeyExist){
      var cacheData= await APICacheManager().getCacheData('login_details');
      return loginResponseJson(cacheData.syncData);
    }
  }
  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheDBModel= APICacheDBModel(key: 'login_details', syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }
  static Future<void> logout(BuildContext context) async{
    await APICacheManager().deleteCache('login_details');
    Get.to(Login());
  }
}