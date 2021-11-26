import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

part 'api_constant.dart';
part 'api_exception.dart';
part 'api_handler.dart';

class Api {
  static final ApiHandler _handler = ApiHandler();

  static Future register(String username, String email, String password) async {
    /* return await _handler.post(registerUrl, {
      'username': username,
      'email': email, 
      'password': password,
    }); */

    // dummy delay
    await Future.delayed(const Duration(seconds: 2));

    // dummy register data
    return {
      'id': 1,
      'username': username,
      'token': username,
      'name': username,
      'email': email,
      'gender': 'male',
      'status': 'active',
    };
  }

  static Future login(String username, String password) async {
    /* return await _handler.post(loginUrl, {
      'username': username,
      'password': password,
    }); */

    // dummy delay
    await Future.delayed(const Duration(seconds: 2));

    // dummy login data
    return {
      'id': 1,
      'username': username,
      'token': username,
      'name': username,
      'email': '$username@gmail.com',
      'gender': 'male',
      'status': 'active',
    };
  }

  static Future user(int id) async {
    return await _handler.get('$userUrl?id=$id');
  }

  static Future users([String? query, int? page]) async {
    String url = '$userUrl?';
    if (query is String && query.isNotEmpty) url += 'name=$query';
    if (page is int && page > 0) url += 'page=$page';
    return await _handler.get(url);
  }
}
