import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import '../services/cache_service.dart';
import '../utils/consts.dart';
import '../utils/get_it_injection.dart';
import '../utils/navigation_helper.dart';

class NetworkManager {

  NetworkManager._();

  factory NetworkManager() {
    return NetworkManager._();
  }
  final https = InterceptedHttp.build(
      interceptors: [
        LoggingInterceptor(),
      ]);

  Uri? _uri;
  final requestHeaders = apiHeaders;
  Future<http.Response> request<T>({
    RequestMethod method = RequestMethod.post,
    String baseUrl = kBaseUrl,
    String baseVersion = kBaseVersion,
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,

  }) async{
    _uri = Uri(
      scheme:"https" ,
      host: baseUrl,
      path: kBaseVersion+endPoint,
      queryParameters: queryParameters,
    );
    log(_uri.toString(),name:"url");
    if(headers!=null){
      requestHeaders.addAll(headers);
    }
    switch (method){
      case RequestMethod.get:
        return await https.get(_uri!, headers: requestHeaders,params:queryParameters );
      case RequestMethod.post:
        return await https.post(_uri!,headers: requestHeaders, body: json.encode(body),);
      case RequestMethod.patch:
        return await https.patch(_uri!,headers: requestHeaders, body: json.encode(body),);
      case RequestMethod.put:
        return await https.put(_uri!,headers: requestHeaders, body: json.encode(body),);
      case RequestMethod.delete:
        return await https.delete(_uri!,headers: requestHeaders, body: json.encode(body),);
      default:
        return await https.post(_uri!, headers: requestHeaders, body: json.encode(body),);
    }
  }

  Future<http.StreamedResponse> requestWithFormData<T>({
    RequestMethod? method,
    String baseUrl = kBaseUrl,
    String baseVersion = kBaseVersion,
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,

  }) async{
    _uri = Uri(
      scheme:"https" ,
      host: baseUrl,
      path: kBaseVersion+endPoint,
      queryParameters: queryParameters,
    );
    if(headers!=null){
      requestHeaders.addAll(headers);
    }
    // requestHeaders.addAll({
    //   "Authorization":getIt<CacheService>().getUserToken()??"",
    //   "lang":getIt<NavHelper>().navigatorKey.currentState?.context.locale.languageCode??"en"
    // });
    var request = http.Request(method?.name.toUpperCase()??'POST', _uri!);
    request.body = json.encode(body);
    request.headers.addAll(requestHeaders);
    log(_uri.toString(),name:"url");
    log(request.body,name:"body");
    log(request.headers.toString(),name:"headers");
    return await request.send();
  }


  Future<http.StreamedResponse> requestWithFile({
    String baseUrl = kBaseUrl,
    String baseVersion = kBaseVersion,
    required String endPoint,
    Map<String,File>? files,
    Map<String, String>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,

  }) async{
    _uri = Uri(
      scheme:"https" ,
      host: baseUrl,
      path: kBaseVersion+endPoint,
      queryParameters: queryParameters,
    );
    print(_uri);
    if(headers!=null){
      requestHeaders.addAll(headers);
    }
    var request = http.MultipartRequest('POST',_uri!);
    request.fields.addAll(body??{});
    request.headers.addAll({
      ...requestHeaders,
      "Authorization":getIt<CacheService>().getUserToken()??"",
      "Accept-Language":getIt<NavHelper>().navigatorKey.currentState?.context.locale.languageCode??"en"
    });
    request.files.addAll(
        files?.entries.map((e) => http.MultipartFile(e.key,
          e.value.readAsBytes().asStream(), e.value.lengthSync(),
          filename: e.value.path.split("/").last,),)??{}
    );
    return await request.send();

  }
}

enum RequestMethod {
  get,
  head,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch,
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    data.headers.addAll({
      "Authorization":getIt<CacheService>().getUserToken()??"",
      "Accept-Language":getIt<NavHelper>().navigatorKey.currentState?.context.locale.languageCode??"en"
    });
    log(data.toString(),name: "data ${data.baseUrl}");
    log(data.body.toString(),name: "body ${data.baseUrl}");
    log(data.params.toString(),name: "params ${data.baseUrl}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    log(data.toString(),name: "data response ${data.request?.baseUrl}");
    log(data.body.toString(),name: "body response ${data.request?.baseUrl}");
    return data;
  }

}