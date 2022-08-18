import 'dart:ui';

class sabitler {
//colors
  static const Color clr_purple = Color(0xFF9C27B0);
  static const Color clr_blue = Color(0xFF548CFF);
  static const Color clr_red = Color(0xFFF44336);
  static const Color clr_orange = Color(0xFFFF682D);
  static const Color clr_light_grey = Color(0xAAD3D3D3);

  //static const String url = "";
  static const String url = "";
  static const String urlGetSeans = "/api/GetSeansList";
  static const String urlBiletNo = "/api/GetBiletDetay?BiletNo=";
  // static const String loginApi = url + "/api/CheckUser";
  static const String urlSalonGiris = "/api/";

  static String userData = "USER_DATA";
  static String isOnBoard = "IS_ONBOARD";
  static String isLoggedIn = "IS_LOGGED_IN";

  //Validations REGEX
  static const String PATTERN_EMAIL =
      "^([0-9a-zA-Z]([-.+\\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\\w]*[0-9a-zA-Z]\\.)+[a-zA-Z]{2,9})\$";
  static const String PATTERN_GSM = "([(+]*[0-9]+[()+. -]*)";

  

  static const String authorization = "---";
}
