import 'package:flutter/widgets.dart';
import 'package:sof/models/ReputationUser.dart';

import '../services/SOFApiService.dart';

class ReputationHistoryProvider with ChangeNotifier {
  final SOFApiService _apiService = SOFApiService();
  final List<ReputationUser> _reputationHistories = [];
  bool _isLoading = false;
  bool _isHasMoreData = true;

  List<ReputationUser> get reputationHistories => _reputationHistories;
  bool get isLoading => _isLoading;
  bool get isHasMoreData => _isHasMoreData;

  Future<void> fetchItemReputationListApi({required int userId, int page = 1, int pageSize = 30}) async {
    if (_isLoading || !_isHasMoreData) return;
    _isLoading = true;
    notifyListeners();

    _apiService.getUserDetail(userId: userId, page: page, pageSize: pageSize).then(
      (value) {
        if (value.data == null || (value.data != null && value.data!.reputationUser.isEmpty)) {
          _isHasMoreData = false;
        } else {
          _reputationHistories.addAll(value.data!.reputationUser);
          _isLoading = false;
          notifyListeners();
        }
      },
    ).onError(
      (error, stackTrace) {},
    );
  }
}
