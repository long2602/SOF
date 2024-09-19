import 'package:intl/intl.dart';
import 'package:sof/commons/DefineArgumentKey.dart';

class ReputationUser {
  String? reputationHistoryType;
  int? reputationChange;
  int? postId;
  int? creationDate;
  int? userId;

  ReputationUser({
    this.reputationHistoryType,
    this.reputationChange,
    this.postId,
    this.creationDate,
    this.userId,
  });

  String formatCreationDate({String convertFormat = "yyyy MMM dd, HH:mm"}) {
    DateTime inputDate = DateTime.fromMillisecondsSinceEpoch(creationDate! * 1000);
    return DateFormat(convertFormat).format(inputDate);
  }

  String formatReputationHistoryType() {
    return reputationHistoryType != null ? reputationHistoryType!.split('_').last : "";
  }

  ReputationUser.fromJson(Map<String, dynamic> data) {
    reputationHistoryType = data[DefineArgumentKey.reputationHistoryType];
    reputationChange = data[DefineArgumentKey.reputationChange];
    postId = data[DefineArgumentKey.postId];
    creationDate = data[DefineArgumentKey.creationDate];
    userId = data[DefineArgumentKey.userId];
  }
}
