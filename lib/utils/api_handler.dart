// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
import 'package:social_manager/models/history.dart';
import 'package:social_manager/models/service.dart';
import 'package:social_manager/models/service_media_statistics.dart';
import 'package:social_manager/models/user.dart';
import 'package:social_manager/utils/store.dart';

class ApiHandler {
  const ApiHandler._();
  static late final Dio _dio;
  static void init() {
    _dio = Dio();
    _dio.options.baseUrl = 'http://spctiy.pythonanywhere.com/';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  static String get imageBaseUrl => _dio.options.baseUrl;

  static Future<Response> _call(
    String path, {
    String method = 'POST',
    Map<String, dynamic>? headers,
    Map<String, dynamic>? body,
    Map<String, String>? query,
  }) async {
    Map<String, dynamic> _headers =
        Map<String, dynamic>.from(_dio.options.headers);
    if (headers != null) _headers.addAll(headers);

    // the server is a shitty fast server, so i didn't implement token
    // i know this is wrong but what the hell
    body = body ?? <String, dynamic>{};
    if (Store.user != null) body['user_id'] = Store.user!.phone;
    Uri uri = Uri.parse(_dio.options.baseUrl + path);
    uri = uri.replace(queryParameters: query);
    final Response response = await _dio.request(
      uri.toString(),
      data: json.encode(body),
      options: Options(
        method: method,
        headers: _headers,
        validateStatus: (_) => true,
      ),
    );

    return response;
  }

  static Future<User> login({
    required String phone,
    required String password,
  }) async {
    Map<String, dynamic> body = {
      'phone': phone,
      'password': password,
    };
    Response response = await _call(
      '/users/login',
      body: body,
    );

    if (response.statusCode != 200) {
      throw response.statusCode!;
    }
    return User.fromRawJson(response.data);
  }

  static Future<User> signup({
    required String name,
    required String phone,
    required String password,
  }) async {
    Map<String, dynamic> body = {
      'name': name,
      'phone': phone,
      'password': password,
    };
    Response response = await _call(
      '/users/signup',
      body: body,
    );
    if (response.statusCode != 200) {
      throw response.statusCode!;
    }

    return User.fromRawJson(response.data);
  }

  static Future<List<MediaService>> mediaServices() async {
    Response response = await _call(
      '/services/available_services',
    );
    return (json.decode(response.data) as List)
        .map((e) => MediaService.fromJson(e))
        .toList();
  }

  static Future<User> setServices({
    required List<int> services,
  }) async {
    Map<String, dynamic> body = {
      'services': services,
    };
    Response response = await _call(
      '/users/set_services',
      body: body,
    );

    if (response.statusCode != 200) {
      throw response.statusCode!;
    }
    return User.fromRawJson(response.data);
  }

  static Future<bool> addMediaService({
    required IconData icon,
    required Map<String, String> name,
    required String domain,
    required Uri homePage,
    required Color iconColor,
  }) async {
    Map<String, dynamic> body = {
      'name': name,
      'icon': icon.codePoint,
      'icon_font': icon.fontFamily,
      'icon_package': icon.fontPackage,
      'home_url': homePage.toString(),
      'domain': domain,
      'icon_color': iconColor.value,
    };
    Response response = await _call(
      '/services/add_service',
      body: body,
    );

    return response.statusCode == 200;
  }

  static Future<bool> addHistoryLink({
    required Uri link,
    required MediaService service,
  }) async {
    Map<String, dynamic> body = {
      'link': link.toString(),
      'media': service.id,
    };
    Response response = await _call(
      '/history/add_link',
      body: body,
    );

    return response.statusCode == 200;
  }

  static Future<List<History>> history({required MediaService media}) async {
    Response response = await _call(
      '/history/history',
      query: <String, String>{
        'media': media.id.toString(),
      },
    );
    return History.listFromJson(json.decode(response.data));
  }

  static Future<List<History>> deleteHistory({
    required MediaService media,
    required History history,
  }) async {
    Response response = await _call(
      '/history/delete',
      query: <String, String>{
        'media': media.id.toString(),
        'id': history.id.toString(),
      },
    );
    return History.listFromJson(json.decode(response.data));
  }

  static Future<Uri> saveLink({
    required Uri link,
    required MediaService service,
  }) async {
    Map<String, dynamic> body = {
      'link': link.toString(),
      'media': service.id,
    };
    await _call(
      '/saved_link/add_link',
      body: body,
    );

    return link;
  }

  static Future<List<History>> getSavedLinks(
      {required MediaService media}) async {
    Response response = await _call(
      '/saved_link/links',
      query: <String, String>{
        'media': media.id.toString(),
      },
    );
    return History.listFromJson(json.decode(response.data));
  }

  static Future<List<History>> deleteLink({
    required MediaService media,
    required History history,
  }) async {
    Response response = await _call(
      '/saved_link/delete',
      query: <String, String>{
        'media': media.id.toString(),
        'id': history.id.toString(),
      },
    );
    return History.listFromJson(json.decode(response.data));
  }

  static Future<List<ServiceMediaStatistics>> statistics() async {
    Response response = await _call(
      '/history/statistics',
    );
    return ServiceMediaStatistics.listFromJson(json.decode(response.data));
  }
}
