import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sof/commons/DefineApiServer.dart';
import 'package:sof/commons/DefineServerErrorCode.dart';
import 'package:sof/models/User.dart';

class HandleApi {
  Future<User?> fetchGetUser(int page, int pageSize, String site) async {
    User user;
    Response? response;
    try {
      var uri = Uri.https(DefineApiServer.serverBaseUrl, DefineApiServer.serverGetUsers, {
        "page": "1",
        "pagesize": "30",
        "site": site,
      });

      var headers = {
        "Accept": "application/json;charset=utf-t",
        "Accept-Language": "en",
      };

      response = await get(
        uri,
        headers: headers,
      ).timeout(const Duration(seconds: 30), onTimeout: () => Response('timeout', 408));

      print("[] ${response.body}");
      user = User.fromJson(jsonDecode(response.body));
    } on HandshakeException catch (_) {
      debugPrint("[Error] HandshakeException");
      return null;
    } on TimeoutException catch (_) {
      debugPrint("[Error] TimeoutException");
      return null;
    } on ClientException catch (_) {
      debugPrint("[Error] ClientException");
      return null;
    } on Exception catch (e) {
      debugPrint("[Error] Exception: ${e.toString()}");
      return null;
    }
    return user;
  }

  Future<User?> getUserDetail(int userId, int page, int pageSize, String site) async {
    User user;
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

      print("[] ${response.body}");
      user = User.fromJson(jsonDecode(response.body));

      switch (response.statusCode) {
        case DefineServerErrorCode.SUCCESS:
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
    } on HandshakeException catch (_) {
      debugPrint("[Error] HandshakeException");
      return null;
    } on TimeoutException catch (_) {
      debugPrint("[Error] TimeoutException");
      return null;
    } on ClientException catch (_) {
      debugPrint("[Error] ClientException");
      return null;
    } on Exception catch (e) {
      debugPrint("[Error] Exception: ${e.toString()}");
      return null;
    }
    return user;
  }
}
