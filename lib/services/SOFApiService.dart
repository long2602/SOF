import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sof/commons/DefineApiServer.dart';
import 'package:sof/commons/DefineServerErrorCode.dart';
import 'package:sof/models/ApiResponse.dart';
import 'package:sof/models/ItemListModel.dart';

class SOFApiService {
  Future<ApiResponse<ItemUserListModel>> fetchListUsers({int page = 1, int pageSize = 30}) async {
    ApiResponse<ItemUserListModel> apiResponse = ApiResponse.loading();
    Response? response;
    try {
      var uri = Uri.https(DefineApiServer.serverBaseUrl, DefineApiServer.serverGetUsers, {
        "page": page.toString(),
        "pagesize": pageSize.toString(),
        "site": DefineApiServer.serverSite,
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

  Future<ApiResponse<ItemReputationUserListModel>> getUserDetail({required int userId, int page = 1, int pageSize = 30}) async {
    ApiResponse<ItemReputationUserListModel> apiResponse = ApiResponse.loading();
    Response? response;
    try {
      var uri = Uri.https(DefineApiServer.serverBaseUrl, DefineApiServer.serverGetDetailUser(userId), {
        "page": page.toString(),
        "pagesize": pageSize.toString(),
        "site": DefineApiServer.serverSite,
      });

      var headers = {
        "Accept": "application/json;charset=utf-t",
        "Accept-Language": "en",
      };

      response = await get(
        uri,
        headers: headers,
      ).timeout(const Duration(seconds: 10), onTimeout: () => Response(DefineServerErrorCode.messageTIMEOUT, DefineServerErrorCode.TIMEOUT));

      apiResponse = ApiResponse(
        status: Status.Complete,
        statusCode: response.statusCode,
        message: messageResponse(response),
        data: ItemReputationUserListModel.fromJson(jsonDecode(response.body)),
      );
    } on Exception catch (e) {
      debugPrint("[Error] Exception: ${e.toString()}");
      return ApiResponse.error(e.toString());
    }
    return apiResponse;
  }

  String messageResponse(Response response) {
    switch (response.statusCode) {
      case DefineServerErrorCode.SUCCESS:
        return DefineServerErrorCode.messageSUCCESS;
      case DefineServerErrorCode.BAD_PARAMETER:
        return DefineServerErrorCode.messageBAD_PARAMETER;
      case DefineServerErrorCode.ACCESS_TOKEN_REQUIRED:
        return DefineServerErrorCode.messageACCESS_TOKEN_REQUIRED;
      case DefineServerErrorCode.INVALID_ACCESS_TOKEN:
        return DefineServerErrorCode.messageINVALID_ACCESS_TOKEN;
      case DefineServerErrorCode.ACCESS_DENIED:
        return DefineServerErrorCode.messageACCESS_DENIED;
      case DefineServerErrorCode.NO_METHOD:
        return DefineServerErrorCode.messageNO_METHOD;
      case DefineServerErrorCode.KEY_REQUIRED:
        return DefineServerErrorCode.messageKEY_REQUIRED;
      case DefineServerErrorCode.ACCESS_TOKEN_COMPROMISED:
        return DefineServerErrorCode.messageACCESS_TOKEN_COMPROMISED;
      case DefineServerErrorCode.WRITE_FAILED:
        return DefineServerErrorCode.messageWRITE_FAILED;
      case DefineServerErrorCode.DUPLICATE_REQUEST:
        return DefineServerErrorCode.messageDUPLICATE_REQUEST;
      case DefineServerErrorCode.INTERNAL_ERROR:
        return DefineServerErrorCode.messageINTERNAL_ERROR;
      case DefineServerErrorCode.THROTTLE_VIOLATION:
        return DefineServerErrorCode.messageTHROTTLE_VIOLATION;
      case DefineServerErrorCode.TEMPORARILY_UNAVAILABLE:
        return DefineServerErrorCode.messageTEMPORARILY_UNAVAILABLE;
      default:
        return "Timeout";
    }
  }
}
