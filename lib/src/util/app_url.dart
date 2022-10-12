class AppUrl {
  static const Map<String,String> servers = {
    'Lukudiplomi' : 'xn--riveill-cxa.fi',
    'Kehityspalvelin' : 'dev.xn--riveill-cxa.fi'
  };
  static const String liveBaseURL = "dev.xn--riveill-cxa.fi";
  static const String localBaseURL = "http://10.0.2.2:4000/api/";
  static const int appId = 1; //App id for Lukudiplomi
  static const String baseURL = liveBaseURL;
  static const String login = "/api/login";
  static const String logout = "/api/logout";
  static const String registration =  "/api/register";
  static const String forgotPassword =  "/api/forgot-password";
  static const String requestValidationToken = "/api/dispatcher/registration/";
  static const String checkValidationToken = "/api/dispatcher/registration/";
  static const String getContactMethods = "/api/dispatcher/registration/";
  static const String libraryItemInfoUrl = "https://vaara.finna.fi/Record/";
  static const String anonymousApikey = "\$2y\$10\$3xeuku9X5z8YNZNVaDUf0OPRU2Q2t8QJFnIFEGLaWlCtwCEWVLQHu";
}