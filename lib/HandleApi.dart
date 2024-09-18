import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sof/commons/DefineApiServer.dart';
import 'package:sof/commons/DefineServerErrorCode.dart';
import 'package:sof/models/ApiResponse.dart';
import 'package:sof/models/ItemListModel.dart';

class HandleApi {
  Future<ApiResponse<ItemUserListModel>> fetchListUsers(int page, int pageSize, String site) async {
    ApiResponse<ItemUserListModel> apiResponse = ApiResponse.loading();
    Response? response;
    try {
      var uri = Uri.https(DefineApiServer.serverBaseUrl, DefineApiServer.serverGetUsers, {
        "page": page.toString(),
        "pagesize": pageSize.toString(),
        "site": site,
      });

      var headers = {
        "Accept": "application/json;charset=utf-t",
        "Accept-Language": "en",
      };

      response = await get(
        uri,
        headers: headers,
      ).timeout(const Duration(seconds: 10), onTimeout: () => Response('timeout', 408));

      apiResponse = ApiResponse(
        status: Status.Complete,
        statusCode: response.statusCode,
        message: "",
        data: ItemUserListModel.fromJson(jsonDecode(response.body)),
      );
    } on Exception catch (e) {
      debugPrint("[Error] Exception: ${e.toString()}");
      return ApiResponse.error("");
    }
    return apiResponse;
  }

  Future<ApiResponse<ItemReputationUserListModel>> getUserDetail(int userId, int page, int pageSize, String site) async {
    ApiResponse<ItemReputationUserListModel> apiResponse = ApiResponse.loading();
    Response? response;
    try {
      var uri = Uri.https(DefineApiServer.serverBaseUrl, DefineApiServer.serverGetDetailUser(userId), {
        "page": page.toString(),
        "pagesize": pageSize.toString(),
        "site": site,
      });

      var headers = {
        "Accept": "application/json;charset=utf-t",
        "Accept-Language": "en",
      };

      response = await get(
        uri,
        headers: headers,
      ).timeout(const Duration(seconds: 10), onTimeout: () => Response('timeout', 408));

      apiResponse = ApiResponse(
        status: Status.Complete,
        statusCode: response.statusCode,
        message: "",
        data: ItemReputationUserListModel.fromJson(jsonDecode(response.body)),
      );
    } on Exception catch (e) {
      debugPrint("[Error] Exception: ${e.toString()}");
      return ApiResponse.error("");
    }
    return apiResponse;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case DefineServerErrorCode.SUCCESS:
        jsonDecode(response.body);
        break;
      case DefineServerErrorCode.BAD_PARAMETER:
        break;
      case DefineServerErrorCode.ACCESS_TOKEN_REQUIRED:
        break;
      case DefineServerErrorCode.INVALID_ACCESS_TOKEN:
        break;
      case DefineServerErrorCode.ACCESS_DENIED:
        break;
      case DefineServerErrorCode.NO_METHOD:
        break;
      case DefineServerErrorCode.KEY_REQUIRED:
        break;
      case DefineServerErrorCode.ACCESS_TOKEN_COMPROMISED:
        break;
      case DefineServerErrorCode.WRITE_FAILED:
        break;
      case DefineServerErrorCode.DUPLICATE_REQUEST:
        break;
      case DefineServerErrorCode.INTERNAL_ERROR:
        break;
      case DefineServerErrorCode.THROTTLE_VIOLATION:
        break;
      case DefineServerErrorCode.TEMPORARILY_UNAVAILABLE:
        break;
    }
  }
}
