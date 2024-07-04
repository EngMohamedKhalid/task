import 'dart:convert';

import '../../app/error/exceptions.dart';

class GlobalResponseModel {
  GlobalResponseModel({
    this.success,
    this.data,
    this.authError,
    this.key,
    this.msg,});

  factory GlobalResponseModel.fromJson(String source) {
    try {
      return GlobalResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
    } catch (e) {
      throw DataParsingException(e.toString());
    }
  }
  GlobalResponseModel.fromMap(Map<String, dynamic> json) {
    success = json['status'];
    key = json['code'];
    authError = false;
    data = json['articles'];
    msg = json['message'];
    // errors = json['msg'] != null ? json['Errors'].cast<String>() : [];
  }
  String? success;
  bool? authError;
  dynamic data;
  String? msg;
  int? key;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = success;
    map['data'] = data;
    map['message'] = msg;
    return map;
  }

}