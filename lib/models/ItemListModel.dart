import 'package:sof/commons/DefineArgumentKey.dart';
import 'package:sof/models/ReputationUser.dart';
import 'package:sof/models/User.dart';

class ItemListModel {
  bool? hasMore;
  int? quotaMax;
  int? quotaRemaining;

  ItemListModel({
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });
}

class ItemUserListModel extends ItemListModel {
  List<User> users = [];

  ItemUserListModel({required this.users, super.hasMore, super.quotaMax, super.quotaRemaining});

  factory ItemUserListModel.fromJson(Map data) {
    return ItemUserListModel(
      users: ((data[DefineArgumentKey.items] as List) ?? []).map((e) {
        return User.fromJson(e);
      }).toList(),
      hasMore: data[DefineArgumentKey.hasMore] ?? false,
      quotaMax: data[DefineArgumentKey.quotaMax] ?? 0,
      quotaRemaining: data[DefineArgumentKey.quotaRemaining] ?? 0,
    );
  }
}

class ItemReputationUserListModel extends ItemListModel {
  List<ReputationUser> reputationUser = [];

  ItemReputationUserListModel({required this.reputationUser, super.hasMore, super.quotaMax, super.quotaRemaining});

  factory ItemReputationUserListModel.fromJson(Map data) {
    return ItemReputationUserListModel(
      reputationUser: ((data[DefineArgumentKey.items] as List) ?? []).map((e) {
        return ReputationUser.fromJson(e);
      }).toList(),
      hasMore: data[DefineArgumentKey.hasMore] ?? false,
      quotaMax: data[DefineArgumentKey.quotaMax] ?? 0,
      quotaRemaining: data[DefineArgumentKey.quotaRemaining] ?? 0,
    );
  }
}
