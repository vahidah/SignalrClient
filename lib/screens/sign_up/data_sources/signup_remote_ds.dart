import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '/core/constants/apis.dart';
import '/core/error/exception.dart';
import '../interfaces/signup_ds_interface.dart';
import '../usecases/image_usecase.dart';
import 'package:http/http.dart' as http;


class SignUpRemoteDataSource implements SignUpDataSourceInterface {
  // final LoginLocalDataSource localDataSource;
  // LoginRemoteDataSource(this.localDataSource);


  @override
  Future<int> image({required ImageRequest imageRequest}) async {
    Dio dio = Dio(  );

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    var data = await imageRequest.formData();
    final response = await dio.post(Apis.baseUrl, data: data);

    debugPrint("status code is ${response.statusCode}");
    debugPrint("");

    if (response.statusCode == 200) {
          return 1;
    } else {
      debugPrint("upload image failed");
      return 0;
    }
  }

}