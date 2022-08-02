import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  // this is our link that we will get data from
  //   https://newsapi.org/v2/top-headlines?countery=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // I made the headers in another place you will find
        // it below and it began with dio!.options.headers
        // headers: {'Content-Type': 'application/json', 'lang': 'en'}),
      ),
    );
  }

  // here I use this to retrieve data note that the url != baseUrl
  static Future<Response> getData({
    required String url,
    String lang = 'ar',
    required String token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': 'ar',
      'Authorization': token,
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'ar',
      String? token}) async {
    // I change the header here and put one more property
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    print('we are posting the data in dio helper');
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData(
      {required String url,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query,
      String lang = 'ar',
      String? token}) async {
    // I change the header here and put one more property
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    print('we are puttong the data in dio helper');
    return await dio!.put(url, queryParameters: query, data: data);
  }
}
