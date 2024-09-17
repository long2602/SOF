class DefineServerErrorCode {
  static const int SUCCESS = 200;
  static const int BAD_PARAMETER = 400;
  static const int ACCESS_TOKEN_REQUIRED = 401;
  static const int INVALID_ACCESS_TOKEN = 402;
  static const int ACCESS_DENIED = 403;
  static const int NO_METHOD = 404;
  static const int KEY_REQUIRED = 405;
  static const int ACCESS_TOKEN_COMPROMISED = 406;
  static const int WRITE_FAILED = 407;
  static const int DUPLICATE_REQUEST = 409;
  static const int INTERNAL_ERROR = 500;
  static const int THROTTLE_VIOLATION = 502;
  static const int TEMPORARILY_UNAVAILABLE = 503;
}
