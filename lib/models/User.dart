import 'package:sof/commons/DefineArgumentKey.dart';
import 'package:sof/models/BadgeCount.dart';

class User {
  BadgeCounts badgeCounts;
  int? accountId;
  bool? isEmployee = false;
  int? lastModifiedDate = 0;
  int? lastAccessDate = 0;
  int? reputationChangeYear = 0;
  int? reputationChangeQuarter = 0;
  int? reputationChangeMonth = 0;
  int? reputationChangeWeek = 0;
  int? reputationChangeDay = 0;
  int? reputation = 0;
  int? creationDate = 0;
  String? userType;
  int? userId;
  int? acceptRate = 0;
  String? location;
  String? websiteUrl;
  String? link;
  String? profileImage;
  String? displayName;

  User({
    required this.badgeCounts,
    required this.accountId,
    this.isEmployee = false,
    this.lastModifiedDate = 0,
    this.lastAccessDate = 0,
    this.reputationChangeYear = 0,
    this.reputationChangeQuarter = 0,
    this.reputationChangeMonth = 0,
    this.reputationChangeWeek = 0,
    this.reputationChangeDay = 0,
    this.reputation = 0,
    this.creationDate = 0,
    this.userType,
    required this.userId,
    this.acceptRate = 0,
    this.location,
    this.websiteUrl,
    this.link,
    this.profileImage,
    required this.displayName,
  });

  factory User.fromJson(Map data) {
    return User(
      badgeCounts: BadgeCounts.fromJson(data[DefineArgumentKey.badgeCounts] ?? ""),
      accountId: data[DefineArgumentKey.accountId],
      isEmployee: data[DefineArgumentKey.isEmployee],
      lastModifiedDate: data[DefineArgumentKey.lastModifiedDate],
      lastAccessDate: data[DefineArgumentKey.lastAccessDate],
      reputationChangeYear: data[DefineArgumentKey.reputationChangeYear],
      reputationChangeQuarter: data[DefineArgumentKey.reputationChangeQuarter],
      reputationChangeMonth: data[DefineArgumentKey.reputationChangeMonth],
      reputationChangeWeek: data[DefineArgumentKey.reputationChangeWeek],
      reputationChangeDay: data[DefineArgumentKey.reputationChangeDay],
      reputation: data[DefineArgumentKey.reputation],
      creationDate: data[DefineArgumentKey.creationDate],
      userType: data[DefineArgumentKey.userType],
      userId: data[DefineArgumentKey.userId],
      acceptRate: data[DefineArgumentKey.acceptRate],
      location: data[DefineArgumentKey.location],
      websiteUrl: data[DefineArgumentKey.websiteUrl],
      link: data[DefineArgumentKey.link],
      profileImage: data[DefineArgumentKey.profileImage],
      displayName: data[DefineArgumentKey.displayName],
    );
  }
}
