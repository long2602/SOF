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
  static const int TIMEOUT = 408;
  static const int DUPLICATE_REQUEST = 409;
  static const int INTERNAL_ERROR = 500;
  static const int THROTTLE_VIOLATION = 502;
  static const int TEMPORARILY_UNAVAILABLE = 503;

  static const String messageCommonError = "Failed to load data. Please try again later.";
  static const String messageSUCCESS = "The operation was successful.";
  static const String messageBAD_PARAMETER = "One or more parameters are incorrect or missing.";
  static const String messageACCESS_TOKEN_REQUIRED = "The request requires an access token, which is missing.";
  static const String messageINVALID_ACCESS_TOKEN = "The provided access token is invalid.";
  static const String messageACCESS_DENIED = "The user or app does not have permission to access the requested resource.";
  static const String messageNO_METHOD = "The API endpoint or method was not specified or is unavailable.";
  static const String messageKEY_REQUIRED = "An API key is required but not provided.";
  static const String messageACCESS_TOKEN_COMPROMISED = "The access token has been compromised or is no longer valid.";
  static const String messageWRITE_FAILED = "There was an error while attempting to write data.";
  static const String messageTIMEOUT = "Timeout.";
  static const String messageDUPLICATE_REQUEST = "The request has already been submitted.";
  static const String messageINTERNAL_ERROR = "The server encountered an unexpected error.";
  static const String messageTHROTTLE_VIOLATION = "The request rate exceeds the allowed limit.";
  static const String messageTEMPORARILY_UNAVAILABLE = "The requested service is temporarily unavailable.";
}
