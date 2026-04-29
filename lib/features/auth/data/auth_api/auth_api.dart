import 'dart:convert';
import 'package:ecommerce_app_api_26/core/endpoints/endpoints.dart';
import 'package:ecommerce_app_api_26/features/auth/data/auth_api/api_helper.dart';
import 'package:ecommerce_app_api_26/features/auth/data/auth_api/signup_model.dart';
import 'package:ecommerce_app_api_26/features/auth/models/loginModel/error_model.dart';
import 'package:ecommerce_app_api_26/features/auth/models/token_model.dart';
import 'package:http/http.dart' as http;

class AuthApi {
  /// login
  Future<TokenModel> login(String email, String password) async {
    Uri url = Uri.parse(Endpoints.baseUrl + Endpoints.loginEndpoint);
    var response = await http.post(
      url,
      body: {"email": email, "password": password},
    );
    String responseBody = response.body;
    var json = jsonDecode(responseBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      TokenModel tokens = TokenModel.fromJson(json);
      ApiHelper.saveAccessToken(tokens.accessToken!);
      ApiHelper.saveRefreshToken(tokens.accessToken!);
      return tokens;
    } else {
      ErroeModel error = ErroeModel.fromJson(json);
      throw Exception(error.message);
    }
  }

  /// sign Up
  Future<SignupModel> signup(String name, String email, String password) async {
    Uri url = Uri.parse(Endpoints.baseUrl + Endpoints.signUpEndpoint);
    Map<String, dynamic> requestBody = {
      "name": name,
      "email": email,
      "password": password,
      "avatar": "https://i.imgur.com/LDOO4Qs.jpg",
    };
    var response = await http.post(
      url,
      body: jsonEncode(requestBody),
      headers: {"Content-Type": "application/json"},
    );
    String responseBody = response.body;
    var json = jsonDecode(responseBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return SignupModel.fromJson(json);
    } else {
      ErroeModel error = ErroeModel.fromJson(json);
      throw Exception(error.message);
    }
  }
}
