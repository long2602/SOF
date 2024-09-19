import 'package:flutter/cupertino.dart';
import 'package:sof/services/SOFApiService.dart';
import 'package:sof/services/SharedPreferenceService.dart';

import '../models/User.dart';

class UserProvider with ChangeNotifier {
  final SOFApiService _apiService = SOFApiService();
  final SharedPreferenceService _sharedService = SharedPreferenceService();
  bool _isLoading = false;
  bool _isHasMoreData = true;
  final List<User> _users = [];
  List<int> _userBookMarkedIds = [];
  String _errorMessage = "";

  UserProvider() {
    fetchItemUserListApi();
    fetchUsersBookMarked();
  }

  bool get isLoading => _isLoading;
  bool get isHasMoreData => _isHasMoreData;
  List<User> get users => _users;
  List<User> get usersBookMarked => _users.where((element) => _userBookMarkedIds.contains(element.userId)).toList();
  List<int> get userBookMarkedIds => _userBookMarkedIds;
  String get errorMessage => _errorMessage;

  Future<void> fetchItemUserListApi({int page = 1, int pageSize = 30}) async {
    if (_isLoading || !_isHasMoreData) return;
    _isLoading = true;
    _errorMessage = "";
    notifyListeners();

    _apiService.fetchListUsers(page: page, pageSize: 30).then(
      (value) {
        if (value.data == null || (value.data != null && value.data!.users.isEmpty)) {
          _isHasMoreData = false;
        } else {
          _users.addAll(value.data!.users);
          _isLoading = false;
          _errorMessage = "";
          notifyListeners();
        }
      },
    ).onError(
      (error, stackTrace) {
        _isLoading = false;
        _errorMessage = "Failed to load data. Please try again later.";
        notifyListeners();
      },
    );
  }

  Future<void> fetchUsersBookMarked() async {
    _sharedService.getBookMarkedUsers().then(
      (value) {
        _userBookMarkedIds = value;
        notifyListeners();
      },
    );
  }

  void toggleBookmark(int userId) async {
    if (_userBookMarkedIds.contains(userId)) {
      await _sharedService.removeBookmark(userId);
      _userBookMarkedIds.remove(userId);
    } else {
      await _sharedService.addBookmark(userId);
      _userBookMarkedIds.add(userId);
    }
    notifyListeners();
  }
}
