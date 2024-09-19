class DefineApiServer {
  static String serverBaseUrl = "api.stackexchange.com";
  static String serverGetUsers = "/2.2/users";
  static String serverSite = "stackoverflow";
  static String serverGetDetailUser(int userId) {
    return "/2.2/users/$userId/reputation-history";
  }
}
