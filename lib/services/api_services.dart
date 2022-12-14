import 'dart:convert';

import 'package:getx/config.dart';
import 'package:getx/models/login_request.dart';
import 'package:getx/models/login_response.dart';
import 'package:getx/models/register_request.dart';
import 'package:getx/models/register_response.dart';
import 'package:getx/services/shared_service.dart';
import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    if(response.statusCode == 200){
      //SHARED
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    }
    else{
      return false;
    }
  }

  static Future<RegisterResponseModel> register(RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));
    return registerResponseModel(response.body);
  }



}
