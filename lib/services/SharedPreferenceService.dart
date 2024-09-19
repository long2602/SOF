import 'package:shared_preferences/shared_preferences.dart';
import 'package:sof/commons/DefineArgumentKey.dart';

class SharedPreferenceService {
  Future<List<int>> getBookMarkedUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(DefineArgumentKey.shareBookMarkedUsers)?.map(int.parse).toList() ?? [];
  }

  Future<void> addBookmark(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(DefineArgumentKey.shareBookMarkedUsers) ?? [];
    bookmarks.add(userId.toString());
    await prefs.setStringList(DefineArgumentKey.shareBookMarkedUsers, bookmarks);
  }

  Future<void> removeBookmark(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(DefineArgumentKey.shareBookMarkedUsers) ?? [];
    bookmarks.remove(userId.toString());
    await prefs.setStringList(DefineArgumentKey.shareBookMarkedUsers, bookmarks);
  }
}
