import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:uco_mad_sem4/data/app_exception.dart';
import 'package:uco_mad_sem4/data/network/base_api_service.dart';
import 'package:uco_mad_sem4/shared/shared.dart';

class NetworkApiService implements BaseApiService{
  @override
  Future getApiResponse(String endpoint) async{
    dynamic responseJson;

    try {
      final response = await http.get(Uri.https(Const.baseUrl, Const.subUrl + endpoint), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', 'key': Const.apiKey,
      }).timeout(const Duration(seconds: 10));
    } on SocketException {
      throw FetchDataException();
    } on TimeoutException {
      throw FetchDataException();
    }
  }

  @override
  Future postApiResponse(String url, data) {
    throw UnimplementedError();
  }
}