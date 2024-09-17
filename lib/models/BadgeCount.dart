import 'package:sof/commons/DefineArgumentKey.dart';

class BadgeCounts {
  int bronze = 0;
  int silver = 0;
  int gold = 0;

  BadgeCounts({
    required this.bronze,
    required this.silver,
    required this.gold,
  });

  factory BadgeCounts.fromJson(Map data) {
    return BadgeCounts(
      bronze: data[DefineArgumentKey.bronze] ?? 0,
      silver: data[DefineArgumentKey.silver] ?? 0,
      gold: data[DefineArgumentKey.gold] ?? 0,
    );
  }

  Map<String, Object> toMap() {
    return {
      DefineArgumentKey.bronze: bronze,
      DefineArgumentKey.silver: silver,
      DefineArgumentKey.gold: gold,
    };
  }
}
