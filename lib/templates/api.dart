import 'dart:io';

/// generate template for api
void api(String project) {
  String dir = '$project/lib/data/network';

  _api(project, dir);
  _constant(project, dir);
  _handler(project, dir);
  _exception(project, dir);
}

void _api(String project, String dir) {
  File('$dir/api.dart').writeAsStringSync('''
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
      'email': '\$username@gmail.com',
      'gender': 'male',
      'status': 'active',
    };
  }

  static Future user(int id) async {
    return await _handler.get('\$userUrl?id=\$id');
  }

  static Future users([String? query, int? page]) async {
    String url = '\$userUrl?';
    if (query is String && query.isNotEmpty) url += 'name=\$query';
    if (page is int && page > 0) url += 'page=\$page';
    return await _handler.get(url);
  }
}''');
}

void _constant(String project, String dir) {
  File('$dir/api_constant.dart').writeAsStringSync('''
part of 'api.dart';

// Dummy API URL
String baseUrl = 'https://gorest.co.in/public/v1';
String registerUrl = '';
String loginUrl = '';
String userUrl = '\$baseUrl/users';''');
}

void _handler(String project, String dir) {
  File('$dir/api_handler.dart').writeAsStringSync('''
part of 'api.dart';

abstract class ApiHandler {
  Future get(String url);
  Future post(String url, dynamic body);
  Future put(String url, dynamic body);
  Future delete(String url);
  
  factory ApiHandler() => _ApiHandlerImpl();
}

class _ApiHandlerImpl implements ApiHandler {
  @override
  Future get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  @override
  Future post(String url, body) async {
    try {
      final response = await http.post(Uri.parse(url), body: body);
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  @override
  Future put(String url, body) async {
    try {
      final response = await http.put(Uri.parse(url), body: body);
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  @override
  Future delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(url));
      return _process(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _process(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 400:
      case 401:
      case 403:
      case 404:
        return json.decode(response.body.toString());
      case 500:
      default:
        return FetchDataException(
          'Error occured while connecting to server with StatusCode : \${response.statusCode}',
        );
    }
  }
}''');
}

void _exception(String project, String dir) {
  File('$dir/api_exception.dart').writeAsStringSync('''
part of 'api.dart';

class ApiException implements Exception {
  final String? _message;
  final String? _prefix;

  ApiException([this._message, this._prefix]);

  @override
  String toString() {
    return '\$_prefix\$_message';
  }
}

class FetchDataException extends ApiException {
  FetchDataException([message]) : super(message, 'Connection Error: ');
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InternalErrorException extends ApiException {
  InternalErrorException([message]) : super(message, 'Internal server error: ');
}''');
}
