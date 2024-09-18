import 'package:flutter/cupertino.dart';
import 'package:sof/HandleApi.dart';
import 'package:sof/models/ItemListModel.dart';

import '../models/ApiResponse.dart';

class HomeScreenViewModel with ChangeNotifier {
  ApiResponse<ItemUserListModel> itemUserList = ApiResponse.loading();

  void setItemUserList(ApiResponse<ItemUserListModel> response) {
    itemUserList = response;
    notifyListeners();
  }

  Future<void> fetchItemUserListApi() async {
    setItemUserList(ApiResponse.loading());

    HandleApi().fetchListUsers(1, 30, "stackoverflow").then(
      (value) {
        setItemUserList(ApiResponse.completed(value.data));
      },
    ).onError(
      (error, stackTrace) {
        setItemUserList(ApiResponse.error(error.toString()));
      },
    );
  }
}
